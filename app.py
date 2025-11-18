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
    return render_template('users.html')

@app.route('/movies')
def movies():
    return render_template('movies.html')

@app.route('/saved-movies')
def saved_movies():
    return render_template('saved_movies.html')

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
    movies_data = cur.fetchall()
    
    return render_template('watched_movies.html', watched_movies=watched_movies_data,
                            users=users_data, movies=movies_data)
    
    except Exception as e:
        print(f"Error fetching watched movies: {e}")
        return "An error occurred while fetching watched movies.", 500

# Listener 
if __name__ == '__main__':
    app.run(port=64890, debug=True)