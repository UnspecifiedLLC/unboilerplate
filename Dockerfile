FROM us.gcr.io/unspec-utility/python36:latest
ADD ./app/requirements.txt /tmp/requirements.txt
RUN pip install --require-hashes -r /tmp/requirements.txt
ADD ./tests/test-requirements.txt /tmp/test-requirements.txt
RUN pip install --require-hashes -r /tmp/test-requirements.txt

ADD ./app/src /code
ADD ./tests /tests
# RUN find /code -name "*.pyc" -delete; /
#	find /tests -name "*.pyc" -delete
	 
ENV PYTHONPATH $PYTHONPATH:/code:/tests

WORKDIR ./tests


# CMD ["-m", "unittest"]