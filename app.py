from flask import Flask, jsonify
from flask_mysqldb import MySQL
from flask_cors import CORS
from config import Config

app = Flask(__name__)
CORS(app)

# Configuración
app.config['MYSQL_HOST'] = Config.DB_HOST
app.config['MYSQL_USER'] = Config.DB_USER
app.config['MYSQL_PASSWORD'] = Config.DB_PASSWORD
app.config['MYSQL_DB'] = Config.DB_NAME

mysql = MySQL(app)

# Ruta raíz
@app.route('/', methods=['GET'])
def root():
    return {'status': 'ok', 'message': 'GLPI Data API is running', 'version': '1.0.0'}

# Ruta para obtener equipos
@app.route('/api/computadores', methods=['GET'])
def get_computadores():
    cur = mysql.connection.cursor()
    cur.execute("SELECT id, name, serial, otherserial, comment FROM glpi_computers WHERE is_deleted=0")
    rows = cur.fetchall()
    keys = ['id', 'nombre', 'serial', 'serial_otro', 'comentario']
    data = [dict(zip(keys, row)) for row in rows]
    return jsonify(data)

# Ruta para obtener monitores
@app.route('/api/monitores', methods=['GET'])
def get_monitores():
    cur = mysql.connection.cursor()
    cur.execute("SELECT id, name, serial FROM glpi_monitors WHERE is_deleted=0")
    rows = cur.fetchall()
    keys = ['id', 'nombre', 'serial']
    data = [dict(zip(keys, row)) for row in rows]
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True, port=5001)
