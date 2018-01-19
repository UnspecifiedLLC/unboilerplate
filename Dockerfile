FROM us.gcr.io/unspec-utility/python36:latest
ADD ./app/requirements.txt /tmp/requirements.txt
RUN pip install --require-hashes -r /tmp/requirements.txt
ADD ./tests/test-requirements.txt /tmp/test-requirements.txt
RUN pip install --require-hashes -r /tmp/test-requirements.txt

RUN mkdir /app
VOLUME /app
# ADD ./app/src /code
RUN mkdir /tests
VOLUME /tests
# ADD ./tests /tests
	 
ENV PYTHONPATH $PYTHONPATH:/app:/tests

WORKDIR ./tests


# CMD ["-m", "unittest"]