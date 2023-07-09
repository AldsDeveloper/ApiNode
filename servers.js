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

// เปิดใช้งาน middleware สำหรับ parse รูปแบบ JSON และ URL-encoded
app.use(express.json());
app.use(bodyParser.json({ limit: "50mb", }));
app.use(bodyParser.urlencoded({ limit: "50mb",extended: true, }));

// ตั้งค่าเซสชัน
app.use(session({secret: 'frankent',resave: false,saveUninitialized: true,}));


const connection = mysql.createConnection({host: '127.0.0.1',user: 'root',password: 'frankent',database: 'interview',});

// Middleware สำหรับตรวจสอบและรับรองตัวตนผู้ใช้จาก Access Token
const authenticateToken = (req, res, next) => {
  const accessToken = req.session.remember_token;

  // const authorizationHeader = req.session.remember_token;
  // const accessToken = authorizationHeader && authorizationHeader.split(' ')[1];

  if (!accessToken) {
    return res
      .status(401)
      .json({ success: false, message: 'Access token is required' });
  }

  console.log(`token : ${accessToken}`);

  // เชื่อมต่อกับ Laravel API เพื่อตรวจสอบและรับรองตัวตนผู้ใช้
  axios
    .post('http://localhost:8000/api/access/token', null, {
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


// เส้นทาง API สำหรับอัปโหลดรูปภาพโปรไฟล์
app.post(
  '/upload/profile',
  
  upload.single('profile'),
  (req, res) => {
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

// สำหรับการรับค่า Array form-data POST 
app.use(upload.array());

// เส้นทาง API สำหรับการสมัครสมาชิก
app.post('/register', (req, res) => {
  const { email, password, name } = req.body;
  const saltRounds = 10;

  console.log('name:' + name);
  console.log('password:' + password);
  // console.log('password:' + hashedPassword);
  console.log('email:' + email);

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
app.post('/login', (req, res) => {
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

      axios
        .post('http://localhost:8000/api/generate/token', {
          email: email,
          password: password,
        })
        .then((response) => {
          const { success, token } = response.data;

          if (success) {
            // บันทึก userId ในเซสชัน
            req.session.userId = user.id;
            req.session.remember_token = token;

            const updateQuery =
              'UPDATE users SET remember_token = ? WHERE id = ?';
            connection.query(
              updateQuery,
              [token, user.id],
              (updateError, updateResult) => {
                if (updateError) {
                  console.error('Error updating remember_token:', updateError);
                  res.status(500).json({
                    success: false,
                    message: 'Failed to update remember_token',
                  });
                  return;
                }
                res.json({
                  success: true,
                  message: 'Login successful',
                  token: token,
                  user,
                });
              }
            );
          } else {
            return res.status(401).json({
              success: false,
              message: "Haven't generated API access token",
            });
          }
        })
        .catch((error) => {
          console.error('Error verifying access token:', error);
          return res
            .status(500)
            .json({ success: false, message: 'Token internal error' });
        });
    });
  });
});

app.post('/logout', authenticateToken, (req, res) => {
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
