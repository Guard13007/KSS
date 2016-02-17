# EVERYTHING

- Standard style based on Pure CSS.
- Navigation bar:
  - Index
  - Users
  - Saves
  - info: who's turn, time left, who's next
    - Current turn: user<br/>x time left.<br/>Next: user
  - login/logout/create user

## Index

(A lot of this is duplicated on the menu..?)

- Who's turn is it?
- When did their turn start?
- When is their turn over?
- Next turn?
- Where else can we go?
- Latest version for download.

## Saves

- List them (paginate when needed).
  - Link to download.
  - Link to report (page about download itself)
    - ToDo: list filesize, and more data
  - When uploaded? Who uploaded?
  - Latest at top, going to older and older.

## Users

- List them (paginate when needed).
  - List their slots (1 to 7 for day of week, 8 for unassigned)
  - List if they are admin or not.
  - Other features come later.

## Upload

- One master upload end point.
- This is only linked to if the currently logged in player is who's turn it is (or an admin).
- Rejects attempted uploads by non-current player.

## Login/Logout/Create user

- Have login/logout buttons (in menu!!)
- Have login/logout pages??
- Create user is its own page. Users can be created by anyone, are just username and password.
  - Temp: Warn that passwords are transmitted as plaintext, do not re-use passwords!!

### other notes

- Start tracking queries per request. I'm probably going to accidentally make things inefficient.
