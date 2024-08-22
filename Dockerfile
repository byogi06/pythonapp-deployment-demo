# Use an official Python runtime as a parent image
FROM python:3.11-slim-bookworm

WORKDIR /app

COPY src/requirements.txt  requirements.txt

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000

# Run the application
CMD ["python", "src/manage.py", "runserver", "0.0.0.0:8000"]