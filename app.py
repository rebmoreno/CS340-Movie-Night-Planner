# Group 64: Rebeca Moreno Rodriguez, Prisha Velhal
# Movie Night Planner Management System
# Main Flask application
#
# Citation: Structure based on CS340 Flask starter code and Activity 2 tutorial

from flask import Flask, render_template, request, redirect
from flask_mysqldb import MySQL
from flask import request
import os

app = Flask(__name__)

# Database configuration 
app.config['MYSQL_HOST'] = 'classmysql.engr.oregonstate.edu'
app.config['MYSQL_USER'] = 'cs340_morenreb'        
app.config['MYSQL_PASSWORD'] = 'r7QWXdLO6Atd'      
app.config['MYSQL_DB'] = 'cs340_morenreb'          
app.config['MYSQL_CURSORCLASS'] = "DictCursor"

mysql = MySQL(app)

# Routes
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/reset-database')
def reset_database():

    try: 
        cur = mysql.connection.cursor()
        cur.execute("CALL sp_ResetDatabase();")
        mysql.connection.commit()
        
        print("Database reset successfully")
        return redirect('/')

    except Exception as e:
        print(f"Error resetting database: {e}")
        return "An error occurred while resetting the database.", 500

@app.route('/delete-john-demo')
def delete_john_demo():

    try:
        cur = mysql.connection.cursor()
        cur.execute("CALL sp_DeleteJohnSmith();")
        mysql.connection.commit()

        print("Deleted John Smith for demo")
        return redirect('/users')

    except Exception as e:
        print(f"Error executing demo delete: {e}")
        return "An error occurred while executing the demo delete.", 500

@app.route('/users')
def users():

    cur = mysql.connection.cursor()
    cur.execute("SELECT userId, name, email FROM Users;")
    users_data = cur.fetchall()
    
    return render_template('users.html', users=users_data)

@app.route('/add-user', methods=['POST'])
def add_user():
    try:
        name = request.form['name']
        email = request.form['email']
        
        cur = mysql.connection.cursor()
        query = "INSERT INTO Users (name, email) VALUES (%s, %s);"
        cur.execute(query, (name, email))
        mysql.connection.commit()
        
        print(f"Added user: {name}")
        return redirect('/users')
    
    except Exception as e:
        print(f"Error adding user: {e}")
        return "An error occurred while adding the user.", 500

@app.route('/update-user', methods=['POST'])
def update_user():
    try:
        user_id = request.form['userId']
        name = request.form['name']
        email = request.form['email']
        
        cur = mysql.connection.cursor()
        query = "UPDATE Users SET name = %s, email = %s WHERE userId = %s;"
        cur.execute(query, (name, email, user_id))
        mysql.connection.commit()
        
        print(f"Updated user ID {user_id}")
        return redirect('/users')
    
    except Exception as e:
        print(f"Error updating user: {e}")
        return "An error occurred while updating the user.", 500

@app.route('/delete-user/<int:user_id>')
def delete_user(user_id):
    try:
        cur = mysql.connection.cursor()
        query = "DELETE FROM Users WHERE userId = %s;"
        cur.execute(query, (user_id,))
        mysql.connection.commit()
        
        print(f"Deleted user ID {user_id}")
        return redirect('/users')
    
    except Exception as e:
        print(f"Error deleting user: {e}")
        return "An error occurred while deleting the user.", 500


@app.route('/movies')
def movies():

    cur = mysql.connection.cursor()
    query = """SELECT movieId, title, genre, release_date, lead_actor, streaming_platform FROM Movies;"""
    cur.execute(query)
    movie_data = cur.fetchall()

    return render_template('movies.html', movies=movie_data)

@app.route('/add-movie', methods=['POST'])
def add_movie():
    try:
        title = request.form['title']
        genre = request.form['genre']
        release_date = request.form.get('release_date') or None
        lead_actor = request.form.get('lead_actor') or None
        streaming_platform = request.form.get('streaming_platform') or None
        
        cur = mysql.connection.cursor()
        query = """INSERT INTO Movies (title, genre, release_date, lead_actor, streaming_platform) 
                   VALUES (%s, %s, %s, %s, %s);"""
        cur.execute(query, (title, genre, release_date, lead_actor, streaming_platform))
        mysql.connection.commit()
        
        print(f"Added movie: {title}")
        return redirect('/movies')
    
    except Exception as e:
        print(f"Error adding movie: {e}")
        return "An error occurred while adding the movie.", 500

@app.route('/update-movie', methods=['POST'])
def update_movie():
    try:
        movie_id = request.form['movieId']
        title = request.form['title']
        genre = request.form['genre']
        release_date = request.form.get('release_date') or None
        lead_actor = request.form.get('lead_actor') or None
        streaming_platform = request.form.get('streaming_platform') or None
        
        cur = mysql.connection.cursor()
        query = """UPDATE Movies 
                   SET title = %s, genre = %s, release_date = %s, 
                       lead_actor = %s, streaming_platform = %s 
                   WHERE movieId = %s;"""
        cur.execute(query, (title, genre, release_date, lead_actor, streaming_platform, movie_id))
        mysql.connection.commit()
        
        print(f"Updated movie ID {movie_id}")
        return redirect('/movies')
    
    except Exception as e:
        print(f"Error updating movie: {e}")
        return "An error occurred while updating the movie.", 500

@app.route('/delete-movie/<int:movie_id>')
def delete_movie(movie_id):
    try:
        cur = mysql.connection.cursor()
        query = "DELETE FROM Movies WHERE movieId = %s;"
        cur.execute(query, (movie_id,))
        mysql.connection.commit()
        
        print(f"Deleted movie ID {movie_id}")
        return redirect('/movies')
    
    except Exception as e:
        print(f"Error deleting movie: {e}")
        return "An error occurred while deleting the movie.", 500

@app.route('/saved-movies')
def saved_movies():

    cur = mysql.connection.cursor()
    query = """
        SELECT 
            Users.name AS user_name,
            Movies.title AS movie_title,
            Movies.genre,
            Movies.streaming_platform,
            SavedMovies.saved_date
        FROM SavedMovies
        INNER JOIN Users ON SavedMovies.userId = Users.userId
        INNER JOIN Movies ON SavedMovies.movieId = Movies.movieId;"""

    cur.execute(query)
    saved_movies_data = cur.fetchall()

    # Get users for dropdown
    cur.execute("SELECT userId, name FROM Users;")
    users_data = cur.fetchall()
    
    # Get movies for dropdown
    cur.execute("SELECT movieId, CONCAT(title, ' (', genre, ')') AS display_name FROM Movies;")
    movie_data = cur.fetchall()

    return render_template('saved_movies.html', saved_movies=saved_movies_data, users=users_data, movies=movie_data)

@app.route('/add-saved-movie', methods=['POST'])
def add_saved_movie():
    try:
        user_id = request.form['userId']
        movie_id = request.form['movieId']
        saved_date = request.form.get('saved_date') or None
        
        cur = mysql.connection.cursor()
        if saved_date:
            query = "INSERT INTO SavedMovies (userId, movieId, saved_date) VALUES (%s, %s, %s);"
            cur.execute(query, (user_id, movie_id, saved_date))
        else:
            query = "INSERT INTO SavedMovies (userId, movieId) VALUES (%s, %s);"
            cur.execute(query, (user_id, movie_id))
        mysql.connection.commit()
        
        print(f"Added saved movie: User {user_id}, Movie {movie_id}")
        return redirect('/saved-movies')
    
    except Exception as e:
        print(f"Error adding saved movie: {e}")
        return "An error occurred while adding the saved movie.", 500

@app.route('/update-saved-movie', methods=['POST'])
def update_saved_movie():
    try:
        user_id = request.form['userId']
        movie_id = request.form['movieId']
        saved_date = request.form['saved_date']
        
        cur = mysql.connection.cursor()
        query = "UPDATE SavedMovies SET saved_date = %s WHERE userId = %s AND movieId = %s;"
        cur.execute(query, (saved_date, user_id, movie_id))
        mysql.connection.commit()
        
        print(f"Updated saved movie: User {user_id}, Movie {movie_id}")
        return redirect('/saved-movies')
    
    except Exception as e:
        print(f"Error updating saved movie: {e}")
        return "An error occurred while updating the saved movie.", 500

@app.route('/delete-saved-movie', methods=['POST'])
def delete_saved_movie():
    try:
        user_id = request.form['userId']
        movie_id = request.form['movieId']
        
        cur = mysql.connection.cursor()
        query = "DELETE FROM SavedMovies WHERE userId = %s AND movieId = %s;"
        cur.execute(query, (user_id, movie_id))
        mysql.connection.commit()
        
        print(f"Deleted saved movie: User {user_id}, Movie {movie_id}")
        return redirect('/saved-movies')
    
    except Exception as e:
        print(f"Error deleting saved movie: {e}")
        return "An error occurred while deleting the saved movie.", 500
    

@app.route('/watched-movies')
def watched_movies():
    
    cur = mysql.connection.cursor()
    
    # Get watched movies with JOIN
    query = """
        SELECT 
            Users.name AS user_name,
            Movies.title AS movie_title,
            Movies.genre,
            Movies.streaming_platform,
            WatchedMovies.watched_date
        FROM WatchedMovies
        INNER JOIN Users ON WatchedMovies.userId = Users.userId
        INNER JOIN Movies ON WatchedMovies.movieId = Movies.movieId;
    """
    cur.execute(query)
    watched_movies_data = cur.fetchall()
    
    # Get users for dropdown
    cur.execute("SELECT userId, name FROM Users;")
    users_data = cur.fetchall()
    
    # Get movies for dropdown
    cur.execute("SELECT movieId, CONCAT(title, ' (', genre, ')') AS display_name FROM Movies;")
    movie_data = cur.fetchall()
    
    return render_template('watched_movies.html', watched_movies=watched_movies_data,
                            users=users_data, movies=movie_data)

@app.route('/add-watched-movie', methods=['POST'])
def add_watched_movie():
    try:
        user_id = request.form['userId']
        movie_id = request.form['movieId']
        watched_date = request.form.get('watched_date') or None
        
        cur = mysql.connection.cursor()
        if watched_date:
            query = "INSERT INTO WatchedMovies (userId, movieId, watched_date) VALUES (%s, %s, %s);"
            cur.execute(query, (user_id, movie_id, watched_date))
        else:
            query = "INSERT INTO WatchedMovies (userId, movieId) VALUES (%s, %s);"
            cur.execute(query, (user_id, movie_id))
        mysql.connection.commit()
        
        print(f"Added watched movie: User {user_id}, Movie {movie_id}")
        return redirect('/watched-movies')
    
    except Exception as e:
        print(f"Error adding watched movie: {e}")
        return "An error occurred while adding the watched movie.", 500

@app.route('/update-watched-movie', methods=['POST'])
def update_watched_movie():
    try:
        user_id = request.form['userId']
        movie_id = request.form['movieId']
        watched_date = request.form['watched_date']
        
        cur = mysql.connection.cursor()
        query = "UPDATE WatchedMovies SET watched_date = %s WHERE userId = %s AND movieId = %s;"
        cur.execute(query, (watched_date, user_id, movie_id))
        mysql.connection.commit()
        
        print(f"Updated watched movie: User {user_id}, Movie {movie_id}")
        return redirect('/watched-movies')
    
    except Exception as e:
        print(f"Error updating watched movie: {e}")
        return "An error occurred while updating the watched movie.", 500

@app.route('/delete-watched-movie', methods=['POST'])
def delete_watched_movie():
    try:
        user_id = request.form['userId']
        movie_id = request.form['movieId']
        
        cur = mysql.connection.cursor()
        query = "DELETE FROM WatchedMovies WHERE userId = %s AND movieId = %s;"
        cur.execute(query, (user_id, movie_id))
        mysql.connection.commit()
        
        print(f"Deleted watched movie: User {user_id}, Movie {movie_id}")
        return redirect('/watched-movies')
    
    except Exception as e:
        print(f"Error deleting watched movie: {e}")
        return "An error occurred while deleting the watched movie.", 500


# Listener 
if __name__ == '__main__':
    app.run(port=64890, debug=True)