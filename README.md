Here are your **step-by-step notes** from the commands you shared. I’ve organized them in a clear order for Laravel project setup on Ubuntu:

---

# 📘 Notes: Laravel Deployment on Ubuntu

## 1. System Update & Essentials

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install apache2 -y
systemctl start apache2
sudo apt install curl unzip git -y
```

---

## 2. Install Database & PHP

```bash
sudo apt install mysql-server -y
sudo apt install -y php
sudo apt install php-xml php-zip php-gd php-mbstring php-curl php-mysql -y
```

---

## 3. Install Composer

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
sudo mv composer.phar /usr/local/bin/composer
composer -v
```

---

## 4. Clone Laravel Project

```bash
cd /var/www
git clone https://github.com/RohitRawat891997/testing_18.git
cd testing_18/
composer install
chmod -R 777 /var/www/testing_18/
```

---

## 5. Configure Apache for Laravel

```bash
ls -ltrh /etc/apache2/sites-available/
rm -rf /etc/apache2/sites-available/*
vim /etc/apache2/sites-available/laravel.conf

<VirtualHost *:80>
ServerName localhost
DocumentRoot  /var/www/testing_18/public
<Directory /var/www/testing_18/public>

AllowOverride All
Require all granted
</Directory>

ErrorLog ${APACHE_LOG_DIR}/localhost_error.log
CustomLog ${APACHE_LOG_DIR}/localhost_access.log combined
</VirtualHost>

:wq!

a2ensite laravel.conf
systemctl restart apache2
a2enmod rewrite
sudo systemctl restart apache2
```

---

## 6. Laravel Commands

```bash
php artisan optimize:clear
php artisan key:generate
php artisan optimize
php artisan migrate
```

---

## 7. Configure MySQL for Laravel

```sql
mysql -u root -p
-- Inside MySQL/MariaDB shell
CREATE USER 'laraveluser'@'localhost' IDENTIFIED BY 'your_secure_password';
GRANT ALL PRIVILEGES ON *.* TO 'laraveluser'@'localhost';
FLUSH PRIVILEGES;
exit
```

---

## 8. Update Laravel `.env` File

```ini
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=db_test
DB_USERNAME=laraveluser
DB_PASSWORD=your_secure_password
```

```bash
php artisan config:clear
php artisan config:cache
```

---

## 9. Frontend Build (if using Vue/React)

```bash
npm install
npm run build
npm run dev
```

---

👉 These notes cover **full environment setup, database config, Apache setup, and Laravel deployment**.

Do you also want me to create a **sample laravel.conf file** for Apache (step 5), so you can directly copy-paste it?











<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400" alt="Laravel Logo"></a></p>

<p align="center">
<a href="https://github.com/laravel/framework/actions"><img src="https://github.com/laravel/framework/workflows/tests/badge.svg" alt="Build Status"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/dt/laravel/framework" alt="Total Downloads"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/v/laravel/framework" alt="Latest Stable Version"></a>
<a href="https://packagist.org/packages/laravel/framework"><img src="https://img.shields.io/packagist/l/laravel/framework" alt="License"></a>
</p>

## About Laravel

Laravel is a web application framework with expressive, elegant syntax. We believe development must be an enjoyable and creative experience to be truly fulfilling. Laravel takes the pain out of development by easing common tasks used in many web projects, such as:

- [Simple, fast routing engine](https://laravel.com/docs/routing).
- [Powerful dependency injection container](https://laravel.com/docs/container).
- Multiple back-ends for [session](https://laravel.com/docs/session) and [cache](https://laravel.com/docs/cache) storage.
- Expressive, intuitive [database ORM](https://laravel.com/docs/eloquent).
- Database agnostic [schema migrations](https://laravel.com/docs/migrations).
- [Robust background job processing](https://laravel.com/docs/queues).
- [Real-time event broadcasting](https://laravel.com/docs/broadcasting).

Laravel is accessible, powerful, and provides tools required for large, robust applications.

## Learning Laravel

Laravel has the most extensive and thorough [documentation](https://laravel.com/docs) and video tutorial library of all modern web application frameworks, making it a breeze to get started with the framework.

You may also try the [Laravel Bootcamp](https://bootcamp.laravel.com), where you will be guided through building a modern Laravel application from scratch.

If you don't feel like reading, [Laracasts](https://laracasts.com) can help. Laracasts contains thousands of video tutorials on a range of topics including Laravel, modern PHP, unit testing, and JavaScript. Boost your skills by digging into our comprehensive video library.

## Laravel Sponsors

We would like to extend our thanks to the following sponsors for funding Laravel development. If you are interested in becoming a sponsor, please visit the [Laravel Partners program](https://partners.laravel.com).

### Premium Partners

- **[Vehikl](https://vehikl.com)**
- **[Tighten Co.](https://tighten.co)**
- **[Kirschbaum Development Group](https://kirschbaumdevelopment.com)**
- **[64 Robots](https://64robots.com)**
- **[Curotec](https://www.curotec.com/services/technologies/laravel)**
- **[DevSquad](https://devsquad.com/hire-laravel-developers)**
- **[Redberry](https://redberry.international/laravel-development)**
- **[Active Logic](https://activelogic.com)**

## Contributing

Thank you for considering contributing to the Laravel framework! The contribution guide can be found in the [Laravel documentation](https://laravel.com/docs/contributions).

## Code of Conduct

In order to ensure that the Laravel community is welcoming to all, please review and abide by the [Code of Conduct](https://laravel.com/docs/contributions#code-of-conduct).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell via [taylor@laravel.com](mailto:taylor@laravel.com). All security vulnerabilities will be promptly addressed.

## License

The Laravel framework is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
