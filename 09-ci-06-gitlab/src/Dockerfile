FROM centos:7

RUN yum install -y python3 python3-pip
ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN mkdir /python_api

COPY python-api.py /python_api

WORKDIR /python_api

CMD [ "python3", "python-api.py" ]

