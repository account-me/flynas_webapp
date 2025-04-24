FROM python:3.10-slim

# تثبيت المتطلبات الأساسية
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    curl \
    gnupg \
    libglib2.0-0 \
    libnss3 \
    libgconf-2-4 \
    libfontconfig1 \
    libxss1 \
    libappindicator1 \
    libindicator7 \
    fonts-liberation \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libu2f-udev \
    xdg-utils \
    chromium \
    chromium-driver

# ضبط كروم في المسار
ENV CHROME_BIN=/usr/bin/chromium
ENV PATH="$PATH:/usr/lib/chromium/"

# نسخ الملفات
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# تشغيل التطبيق باستخدام gunicorn
CMD gunicorn -b 0.0.0.0:3000 selenium_webapp:app
