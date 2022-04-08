#slim debian with current python
FROM python:3.10-slim
#updates
RUN apt-get update && apt-get -y upgrade
RUN python -m pip install --upgrade pip
#install systemwide
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
#user to drop privileges
RUN useradd --create-home appuser
WORKDIR /home/appuser
USER appuser
# copy the content of the local src directory to the working directory
COPY src/ .
# command to run on container start
CMD [ "python", "./server.py" ] 
