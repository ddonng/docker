FROM ddonng/webasewithsoap:latest

RUN apt-get update
RUN apt-get install -y python3 python3-pip
RUN ln -s /usr/bin/python3 /usr/bin/python && ln -s /usr/bin/pip3 /usr/bin/pip
RUN pip install docx-mailmerge