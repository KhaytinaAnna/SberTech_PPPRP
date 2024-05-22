FROM python:3.11

WORKDIR /app

COPY . /app/

RUN pip3 install  -r requirements.txt

EXPOSE 8000

ENTRYPOINT [ "python" ]

CMD [ "back.py" ]