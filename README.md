# Movie Night Planner Management System
**Group 64: Rebeca Moreno Rodriguez, Prisha Velhal**  
**CS340 - Fall 2025 - Portfolio Project**

## Project Overview
A web-based database application for managing movie watchlists, allowing users to track movies they want to watch and movies they've already watched.

## Technology Stack
- **Backend:** Python Flask
- **Database:** MySQL (MariaDB)
- **Frontend:** HTML, Jinja2 templates
- **Server:** OSU Engineering flip servers

## Database Structure
- **Users:** Store user information
- **Movies:** Catalog of movies with details
- **SavedMovies:** Junction table for user saved movies (M:N relationship)
- **WatchedMovies:** Junction table for user watched movies (M:N relationship)

## Features Implemented
- Full CRUD operations on all entities
- Dynamic dropdown menus for foreign key relationships
- Stored procedures for CREATE, UPDATE, DELETE operations
- Database reset functionality
- Cascade delete to maintain referential integrity

## Code Citations and Originality

### Overall Structure
**Source:** CS340 Flask Starter Application  
**Date:** Fall 2025  
**Originality:** This project is based on the CS340 Flask starter application structure. The following components were adapted from the starter code:
- Flask application setup and configuration
- Database connection using Flask-MySQLdb
- Basic routing pattern
- HTML template structure

### Stored Procedures (PL/SQL)
**Source:** CS340 sp_moviedb.sql example  
**Date:** Fall 2025  
**Originality:** DELIMITER syntax and stored procedure structure adapted from CS340 course example. The following are entirely our original work:
- sp_ResetDatabase - Database recreation logic and sample data specific to Movie Night Planner
- sp_DeleteJohnSmith - Demonstrates CASCADE delete functionality
- sp_AddUser - INSERT operation for Users table
- sp_UpdateUser - UPDATE operation for Users table
- sp_DeleteUser - DELETE operation with CASCADE to junction tables

### SQL Files (DDL and DML)
**Source:** CS340 course examples  
**Date:** Fall 2025  
**Originality:** Basic SQL syntax and @ variable notation adapted from CS340 examples. The following are entirely our original work:
- All table schemas (Users, Movies, SavedMovies, WatchedMovies)
- All foreign key relationships and CASCADE operations
- All sample data
- All JOIN queries for M:N relationships
- Dropdown population queries using CONCAT

### Original Work 
The following components are entirely our own work without any adaptation from course materials or external sources:
- Database schema design (all 4 entities and their relationships)
- Business logic for Movie Night Planner concept
- All CRUD route implementations in app.py
- Stored procedure logic for sp_AddUser, sp_UpdateUser, sp_DeleteUser, sp_DeleteJohnSmith
- Sample data creation (movie titles, user names, dates)
- Junction table CRUD operations
- Dynamic dropdown implementation with CONCAT
- All HTML form designs and layouts
- Navigation structure across pages
- Decision to use SavedMovies and WatchedMovies as separate M:N relationships

### AI Tool Usage
**Jinja2 Template Conversion:**
- **Tool:** Claude (Anthropic)
- **Date:** Fall 2025
- **Prompt:** "My Flask app needs to display database query results in HTML tables and populate dropdowns dynamically. Show me how to add Jinja2 for loops and variable syntax to my existing HTML files."
- **Usage:** Claude helped convert static HTML to dynamic Jinja2 templates with for loops and variable placeholders. Original HTML structure and styling were preserved.
- **Location:** All .html files contain citation comment at top

**No Other AI Usage:**
- Python/Flask code in app.py was written without AI assistance
- SQL queries in DDL.sql, DML.sql, and PL.sql were written without AI assistance
- Database design and schema created without AI assistance

## File Structure
```
project/
├── templates/
│   ├── index.html          # Homepage
│   ├── users.html          # Users management
│   ├── movies.html         # Movies management
│   ├── saved_movies.html   # Saved movies junction table
│   └── watched_movies.html # Watched movies junction table
├── app.py                  # Main Flask application
├── DDL.sql                 # Data Definition Language (table creation)
├── DML.sql                 # Data Manipulation Language (queries)
├── PL.sql                  # Stored Procedures
└── README.md               # This file
```

## Installation & Setup
1. Install required packages: `pip install flask flask-mysqldb`
2. Import DDL.sql to create database schema
3. Import PL.sql to create stored procedures
4. Update database credentials in app.py
5. Run: `python app.py`
6. Access: http://localhost:64890 (or your assigned port)

## Team Member Contributions
- **Rebeca Moreno Rodriguez:** Movies table, WatchedMovies junction table, UPDATE/DELETE stored procedures, peer review fixes
- **Prisha Velhal:** Users table, SavedMovies junction table, CREATE stored procedure, database design

## Changes from Peer Review Feedback
Major improvements based on Step 5 peer feedback:
1. Fixed Movies table display issue (release_date and lead_actor now populate correctly)
2. Added consistent delete buttons to SavedMovies and WatchedMovies tables
3. Removed redundant demo delete functionality from UI
4. Simplified section headers for better UX
5. Improved overall UI consistency across all CRUD operations

## Stored Procedures
- `sp_ResetDatabase()` - Reset database to original sample data
- `sp_DeleteJohnSmith()` - Demonstrate CASCADE delete functionality  
- `sp_AddUser()` - INSERT new user
- `sp_UpdateUser()` - UPDATE user information
- `sp_DeleteUser()` - DELETE user with CASCADE

## Known Limitations
- Database credentials must be manually configured
- No user authentication/login system
- Limited to single-user concurrent access pattern
