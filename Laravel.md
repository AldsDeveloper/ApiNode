## Laravel API 
- เนื่องจากบทสอบสอบมีหลายข้อสร้าง Projrct ขึ้นมา 1 Project และ สร้าง Route เป็นแบบ Api ไว้ทดสอบ
- บททดสอบสำหรับการสมัครงานแอปพลิเคชั่นเบื้องต้น
## Start server 
- Cd /Api และเริ่มต้นการใช้งาน php artisan serve --host localhost --port 8000

## เมื่อเริ่มต้นการใช้งาน Api Application แล้ว สามารถทดสอบ API กับ Postman หรือ Swagger ตามที่ผู้ใช้งานสะดวก

## เปิดการใช้งาน Postman และ Set Header Content-Type : multipart/form-data
## และเปิด Tab ไปยัง Body เลือก Selected ไปที่ form-data

## ผมได้สร้างฐานข้อมูลสำหรับบททดสอบ ซึ่งสามารถนำไป Import เข้า Database/phpmyadmin ได้เลยครับ เป็น Sql 

## Api เบื้องต้นสำหรับการทดสอบ
- Method เป็น POST ทั้้งหมด
- Api ทั้งหมดจะอยู่ใน  Api/routes/api.php ครับ 
- ผมสร้าง Api เป็น Crud สามารถ Create Delete Update Read ได้ทุกอย่างครับและอยู่ในบททดสอบทุกข้อครับ