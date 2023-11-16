FROM python:3

WORKDIR /eksamen_2023/kjell/hello_world

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "./app.py" ]