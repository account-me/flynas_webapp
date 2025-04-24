ARG PORT=443
FROM python:3.10-slim

# تثبيت الأدوات اللازمة والـ Chrome و ChromeDriver
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    gnupg \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    libxss1 \
    libappindicator1 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libu2f-udev \
    xdg-utils \
    chromium \
    chromium-driver

# إعداد متغيرات البيئة لـ Chrome
ENV CHROME_BIN=/usr/bin/chromium
ENV PATH="$PATH:/usr/lib/chromium/"

# تثبيت بايثون و pip
RUN apt-get install -y python3 python3-pip

# نسخ ملف المتطلبات وتثبيت الحزم باستخدام pip
COPY requirements.txt .
RUN pip install --no-cache-dir --break-system-packages -r requirements.txt

# نسخ باقي الملفات إلى الحاوية
COPY . .

# تشغيل التطبيق باستخدام gunicorn بدلاً من uvicorn
CMD ["gunicorn", "-b", "0.0.0.0:3000", "selenium_webapp:app"]

