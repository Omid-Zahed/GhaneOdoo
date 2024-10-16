# Step 1: Use an official Odoo image as the base 
#FROM odoo:17.0
FROM python:3.10
USER root
RUN  mkdir /var/lib/apt/lists/partial
RUN  chmod 755 /var/lib/apt/lists/partial
 # Step 2: Install necessary dependencies 
RUN apt-get update &&  apt-get install -y \ 
    git \ 
    python3-dev \ 
    build-essential \
    libxml2-dev \
    libxslt1-dev \ 
    zlib1g-dev \ 
    libsasl2-dev \ 
    libldap2-dev \ 
    libssl-dev \ 
    libffi-dev \ 
    libjpeg-dev 
   # libpq-dev 
  # Step 3: Clone Odoo source code from GitHub (adjust version if needed) 
  # Step 4: Install Python dependencies (adjust version if needed) 
  COPY  . /odoo
  WORKDIR /odoo 
  RUN python3 -m venv odoo-venv
  RUN . odoo-venv/bin/activate
  RUN pip3 install wheel
  RUN pip3 install -r /odoo/requirements.txt 
  # Step 5: Set Odoo working directory 
 
  # Step 6: Set up custom configuration if needed 
  #COPY ./custom_addons /mnt/extra-addons 
  COPY ./odoo.conf /etc/odoo/odoo.conf 
  # Step 7: Expose the port 
  EXPOSE 8069 
  # Step 8: Set the default command 
  CMD ["python","./odoo-bin","-c","./odoo.conf"]