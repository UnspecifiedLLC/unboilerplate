FROM us.gcr.io/unspec-utility/python36:latest
ADD requirements.txt /tmp/requirements.txt
RUN pip install --require-hashes -r /tmp/requirements.txt
ADD ./src /code
WORKDIR ./code
EXPOSE 5000
# Will be updated to use GUnicorn
ARG app_profile=production
ENV APP_SETTINGS=$app_profile
CMD ["python", "./src/instance/server.py"]