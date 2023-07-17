## Node API 
- บททดสอบสำหรับการสมัครงานแอปพลิเคชั่นเบื้องต้น
## Start server 
- Cd /Api และเริ่มต้นการใช้งาน php artisan serve --host localhost --port 8000
- nodemon servers.js  หรือ node servers.js  
- Defualt การใช้งานเบื้องต้นจะอยู่ที่ Port 3000  http://localhost:3000

## เมื่อเริ่มต้นการใช้งาน Api Application แล้ว สามารถทดสอบ API กับ Postman หรือ Swagger ตามที่ผู้ใช้งานสะดวก

## เปิดการใช้งาน Postman และ Set Header Content-Type : multipart/form-data
## และเปิด Tab ไปยัง Body เลือก Selected ไปที่ form-data

## Api เบื้องต้นสำหรับการทดสอบ
- Method เป็น POST ทั้้งหมด

- http://localhost:3000/register 
- ตัวแปรที่จำเป็นต้องใช้ Name, Email และ Password 

- http://localhost:3000/login
- ตัวแปรที่จำเป็นต้องใช้ Email และ Password

- http://localhost:3000/logout
- ไม่มีตัวแปรที่ต้องใช้งาน แต่จะใช้งาน Api เส้นนี้จำเป็นต้อง Login ก่อน เพราะผมได้เก็บ Token และกำหนด Session ไว้สำหรับการใช้งาน Api ที่จำเป็นต้อง Login

- http://localhost:3000/upload/profile
- ตัวแปรที่ต้องใช้มีแค่ 1 ตัว และเลือกเป็น Type file ชื่อว่า Profile
- Api เส้นนี้ต้อง login ก่อนถึงจะสามารถใช้งานได้

- ** API ทั้งหมดมีการตรวจสอบด้วย Bareer Token หากว่าต้องทดสอบกับ Postman ด้วยตัวเอง ให้ Comment บรรทัดที่ 29 และปิด Comment บรรทัดที่ 33-34 และทดสอบกับ Postman โดยการรับ Token ตอนสมัครการใช้งาน และนำ Token มาใส่ Authorization ใน Postman และเลือกเป็น Bareer
