FROM python:3.6
ADD requirements.txt /tmp/requirements.txt
RUN pip install --require-hashes -r /tmp/requirements.txt
ADD ./src /code
WORKDIR ./code
EXPOSE 5000
# Will be updated to use GUnicorn
ARG app_profile=production
ENV APP_SETTINGS=$app_profile
CMD ["python", "./src/app.py"]

# docker build -t ubuntu1604py36
# FROM ubuntu:16.04

# RUN apt-get update
# RUN apt-get install -y software-properties-common vim
# RUN add-apt-repository ppa:jonathonf/python-3.6
# RUN apt-get update

# RUN apt-get install -y build-essential python3.6 python3.6-dev python3-pip python3.6-venv
# RUN apt-get install -y git

# update pip
# RUN python3.6 -m pip install pip --upgrade
# RUN python3.6 -m pip install wheel