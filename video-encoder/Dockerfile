FROM ubuntu

RUN apt-get update
RUN apt-get install -y ffmpeg x264

COPY /src/run.sh /n/app/

ENTRYPOINT ["bash", "/n/app/run.sh"]
