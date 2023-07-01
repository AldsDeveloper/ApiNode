const express = require('express');
const multer = require('multer');

const bodyParser = require('body-parser');
const path = require('path');
const bcrypt = require('bcrypt');
const mysql = require('mysql');
const app = express();
const upload = multer({ dest: 'public/uploads' });
const axios = require('axios');
const session = require('express-session');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');

// ตั้งค่าเซสชัน
app.use(
  session({
    secret: 'frankent',
    resave: false,
    saveUninitialized: true,
  })
);

app.use(bodyParser.json());
app.use(express.json());

const connection = mysql.createConnection({
  host: '127.0.0.1',
  user: 'root',
  password: 'frankent',
  database: 'interview',
});

// เปิดใช้งาน middleware สำหรับ parse รูปแบบ JSON และ URL-encoded
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Middleware สำหรับตรวจสอบและรับรองตัวตนผู้ใช้จาก Access Token
const authenticateToken = (req, res, next) => {
  const authorizationHeader = req.headers['authorization'];
  const accessToken = authorizationHeader && authorizationHeader.split(' ')[1];

  if (!accessToken) {
    return res
      .status(401)
      .json({ success: false, message: 'Access token is required' });
  }

  console.log(`token : ${accessToken}`);

  // เชื่อมต่อกับ Laravel API เพื่อตรวจสอบและรับรองตัวตนผู้ใช้
  axios
    .post('http://localhost:8080/api/access/token', null, {
      headers: {
        Authorization: `Bearer ${accessToken}`,
      },
    })

    .then((response) => {
      const { success, message } = response.data;
      if (success) {
        // ตรวจสอบและรับรองตัวตนผู้ใช้สำเร็จ
        next();
      } else {
        return res
          .status(401)
          .json({ success: false, message: 'Invalid access token' });
      }
    })
    .catch((error) => {
      console.error('Error verifying access token:', error);
      return res
        .status(500)
        .json({ success: false, message: 'Token internal error' });
    });
};

// เส้นทาง API สำหรับตรวจสอบและรับรองตัวตนผู้ใช้จาก Access Token
app.post('/access/token', authenticateToken, (req, res) => {
  res.json({ success: true, message: 'Access token is valid' });
});

// เส้นทาง API สำหรับสร้างและรับรองตัวตนผู้ใช้จาก Access Token
// app.post('/generate/token', (req, res) => {
//   // เชื่อมต่อกับ Laravel API เพื่อตรวจสอบและรับรองตัวตนผู้ใช้
//   axios
//     .post('http://localhost:8080/api/generate/token', {

//     })

//     .then((response) => {
//       const { success, message } = response.data;
//       if (success) {
//         return res
//           .status(401)
//           .json({ success: true, token: data.token });
//       } else {
//         return res
//           .status(401)
//           .json({ success: false, message: 'Invalid access token' });
//       }
//     })
//     .catch((error) => {
//       console.error('Error verifying access token:', error);
//       return res
//         .status(500)
//         .json({ success: false, message: 'Token internal error' });
//     });

// });

// เส้นทาง API สำหรับการสมัครสมาชิก

app.post('/register', authenticateToken, (req, res) => {
  const { email, password, name } = req.body;
  const saltRounds = 10;

  bcrypt.hash(password, saltRounds, (error, hashedPassword) => {
    if (error) {
      console.error('Error hashing password:', error);
      res.status(500).json({ success: false, message: 'Registration failed' });
      return;
    }

    const newUser = {
      name,
      password: hashedPassword,
      email,
    };

    const query = 'INSERT INTO users SET ?';
    connection.query(query, newUser, (error, result) => {
      if (error) {
        console.error('Error inserting data:', error);
        res
          .status(500)
          .json({ success: false, message: 'Registration failed' });
        return;
      }
      res.json({ success: true, message: 'Registration successful' });
    });
  });
});

// เส้นทาง API สำหรับการเข้าสู่ระบบ
app.post('/login', authenticateToken,  (req, res) => {
  // ตรวจสอบข้อมูลล็อกอิน
  const { email, password } = req.body;

  // เข้าถึงฐานข้อมูลเพื่อตรวจสอบผู้ใช้
  const query = 'SELECT * FROM users WHERE email = ?';
  connection.query(query, [email], (error, results) => {
    if (error) {
      console.error('Error querying database:', error);
      res.status(500).json({ success: false, message: 'Internal error' });
      return;
    }

    if (results.length === 0) {
      res
        .status(401)
        .json({ success: false, message: 'Invalid email or password' });
      return;
    }

    const user = results[0];
    bcrypt.compare(password, user.password, (err, match) => {
      if (err) {
        console.error('Error comparing passwords:', err);
        res.status(500).json({ success: false, message: 'Internal error' });
        return;
      }

      if (!match) {
        res
          .status(401)
          .json({ success: false, message: 'Invalid email or password' });
        return;
      }

      // บันทึก userId ในเซสชัน
      req.session.userId = user.id;

      res.json({
        success: true,
        message: 'Login successful',
        user,
      });
    });
  });
});

// เส้นทาง API สำหรับอัปโหลดรูปภาพโปรไฟล์
app.post('/upload/profile',authenticateToken,upload.single('image'),(req, res) => {
    if (!req.file) {
      res.status(400).json({ success: false, message: 'No file uploaded' });
      return;
    }

    if (!req.session.userId) {
      res.status(401).json({ success: false, message: 'User not logged in' });
      return;
    }

    // รับค่า ID ผู้ใช้จากผู้ใช้ที่เข้าสู่ระบบ Session userId
    const userId = req.session.userId;

    // เก็บไฟล์ที่อัปโหลด
    const imagePath = req.file.path;

    // รับชื่อไฟล์จาก originalname
    const originalFilename = req.file.originalname;

    // สร้างชื่อไฟล์ใหม่ด้วย UUID
    const newFilename = `${uuidv4()}.${originalFilename.split('.').pop()}`;

    // อัปเดตชื่อไฟล์ใหม่ในฐานข้อมูล
    const query = 'UPDATE users SET profile = ? WHERE id = ?';
    connection.query(query, [newFilename, userId], (error, result) => {
      if (error) {
        console.error('Error updating profile image:', error);
        res
          .status(500)
          .json({ success: false, message: 'Failed to upload profile image' });
        return;
      }

      // เปลี่ยนชื่อไฟล์ในโฟลเดอร์อัปโหลด
      fs.rename(imagePath, `public/uploads/${newFilename}`, (error) => {
        if (error) {
          console.error('Error renaming file:', error);
          res.status(500).json({
            success: false,
            message: 'Failed to upload profile image',
          });
          return;
        }

        res.json({
          success: true,
          message: 'Profile image uploaded successfully',
        });
      });
    });
  }
);

app.post('/logout',authenticateToken,  (req, res) => {
  // Destroy the userId stored in the session
  req.session.destroy((error) => {
    if (error) {
      console.error('Error destroying session:', error);
      res.status(500).json({ success: false, message: 'Logout failed' });
      return;
    }

    res.json({ success: true, message: 'Logout successful' });
  });
});

// เริ่มต้นเซิร์ฟเวอร์ที่พอร์ตที่กำหนด
const port = 3000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
