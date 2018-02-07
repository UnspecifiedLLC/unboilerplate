FROM us.gcr.io/unspec-utility/python36:latest

RUN apt-get update -q -q
RUN apt-get install --yes locales

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD ./app/requirements.txt /tmp/requirements.txt
RUN pip install --require-hashes -r /tmp/requirements.txt
ADD ./tests/test-requirements.txt /tmp/test-requirements.txt
RUN pip install --require-hashes -r /tmp/test-requirements.txt

RUN mkdir /app
VOLUME /app

RUN mkdir /tests
VOLUME /tests
	 
ENV PYTHONPATH $PYTHONPATH:/app:/tests

WORKDIR ./tests

# CMD ["-m", "unittest"]