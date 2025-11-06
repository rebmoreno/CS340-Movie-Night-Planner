from flask import Flask, render_template, request, redirect
import os

app = Flask(__name__)

# Routes
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/users')
def users():
    return render_template('users.html')

@app.route('/movies')
def movies():
    return render_template('movies.html')

@app.route('/saved-movies')
def saved_movies():
    return render_template('saved_movies.html')

@app.route('/watched-movies')
def watched_movies():
    return render_template('watched_movies.html')

# Listener 
if __name__ == '__main__':
    app.run(port=64890, debug=True)