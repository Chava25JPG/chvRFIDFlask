from flask import Flask, render_template, request, flash, session, jsonify, redirect, url_for
from basedeconf import Conexion
from templates.controladores.logiAsistencias import lista_Asistencia
from flask_mail import Mail, Message
from registroAsis import Asistencia
from datetime import datetime, timedelta
from prettytable import PrettyTable
from flask_socketio import SocketIO, emit

from flask_session import Session


import secrets


#Base de datos 
conexion = Conexion()
conn = conexion.connect_to_db()
maestro_uid = None
tiempo_registro_maestro = None


#configuracion de la carpeta static

app = Flask(__name__, static_folder='static')
app.config['SESSION_TYPE'] = 'filesystem'

app.secret_key = secrets.token_hex(16)
app.config['SECRET_KEY'] = 'secret_key'

socketio = SocketIO(app)
Session(app)

#La verdad no se, pero funciona

@app.context_processor
def inject_url():
    return dict(url=request.path)

#Rutas








@app.route('/')
def Index():
    return render_template('index.html')










@app.route('/home', methods=['GET', 'POST'])
def login():
    if request.method== 'POST':
        username = request.form['username']
        password = request.form['password']
        # Aquí iría tu lógica de autenticación
        cur = conn.cursor()
        query = "SELECT * FROM usuarios WHERE usuario = %s AND password = %s"
        cur.execute(query, (username, password))
        result = cur.fetchone()
        cur.close()

        if result:
            return render_template('home.html')
        else:
            flash('Usuario o contraseña incorrectos', 'error')
            return render_template('index.html')
    
    return render_template('index.html')






@app.route('/asistencias')
def asistencias():

    cursor = conn.cursor()
    consulta = """
    SELECT alumno.id, alumno.nombre, alumno.apellidoPaterno, alumno.apellidoMaterno,
           grupos.GradoYGrupo, especialidad.nombre, materia.nombre,
           maestro.nombre, asistencia.hora_de_entrada, asistencia.fecha,
           asistencia.asistio
    FROM asistencia
    INNER JOIN alumno ON asistencia.alumno_id = alumno.id
    INNER JOIN grupos ON alumno.grupo_id = grupos.id
    INNER JOIN especialidad ON grupos.especialidad_id = especialidad.id
    INNER JOIN materia ON asistencia.materia_id = materia.id
    INNER JOIN maestro ON asistencia.maestro_id = maestro.id
    ORDER BY asistencia.fecha ASC
    """
    cursor.execute(consulta)
    resultados = cursor.fetchall()
    cursor.close()

    return render_template('asistenciasVis.html', resultados=resultados)
@app.route('/eliAsi/<string:id>')
def eliAsi(id):
    cursor = conn.cursor()
    cursor.execute('DELETE FROM asistencia WHERE id= {0}'.format(id))
    cursor.close()
    flash('Asistencia eliminada')

    return redirect(url_for('asistencias'))






@app.route('/maestros')
def maestrosVis ():

    with conn.cursor() as cursor:
        # Obtener los datos de la tabla maestro
        cursor.execute("SELECT id, nombre, apellidoPaterno, apellidoMaterno, RFIDcard, correo FROM maestro")
        maestros = cursor.fetchall()
        cursor.close()
    return render_template('maestrosVis.html', maestros = maestros)


@app.route('/addMaes', methods=['POST'])
def addMaes():
    if request.method == 'POST':
        nombre = request.form['nombre']
        apellidoP = request.form['apellidoP']
        apellidoM = request.form['apellidoM']
        
        rfid = request.form['rfid']
        correoT = request.form['correoT']
        passw = request.form['passw']
        
        cursor = conn.cursor()
        cursor.execute('INSERT INTO maestro (nombre, apellidoPaterno, apellidoMaterno, RFIDcard, correo, password) VALUES (%s, %s, %s, %s, %s, %s)', (
            nombre, apellidoP, apellidoM, rfid, correoT, passw
        ))
        conn.commit()
        cursor.close()
        return redirect(url_for('maestrosVis'))



@app.route('/editMaes/<string:id>')
def editMaes(id):
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM maestro WHERE id = %s', (id,))
    ediMaestroVar = cursor.fetchall()
    return render_template('editarMaestro.html', maestro = ediMaestroVar[0])


@app.route('/updateMaestro/<id>', methods = ['POST'])
def updateMaes(id):
    if request.method == 'POST':
        nombre = request.form['nombre']
        apellidoP = request.form['apellidoP']
        apellidoM = request.form['apellidoM']
        
        rfid = request.form['rfid']
        correoT = request.form['correoT']
        passw = request.form['pass']

        cursor = conn.cursor()
        cursor.execute("""
        UPDATE maestro
        SET nombre = %s,
            apellidoPaterno = %s,
            apellidoMaterno = %s,
            
            RFIDcard = %s, 
            correo = %s
            password = %s
        WHERE id = %s
        """, (nombre, apellidoP, apellidoM, rfid, correoT, passw, id))
        cursor.close()
        flash ('maestro actualizado')
        return redirect(url_for('maestrosVis'))

@app.route('/eliMaes/<string:id>')
def eliMaes(id):
    cursor = conn.cursor()
    cursor.execute('DELETE FROM maestro WHERE id= {0}'.format(id))
    cursor.close()
    flash('Maestro eliminado')

    return redirect(url_for('maestrosVis'))

















@app.route('/alumnos')
def alumnosVis():
        #obtener los registros de los alumnos
    cursor = conn.cursor()
    query = "SELECT alumno.id, alumno.nombre, alumno.apellidoPaterno, alumno.apellidoMaterno, grupos.GradoYGrupo, especialidad.nombre, alumno.RFIDcard, alumno.CorreoTutor FROM alumno JOIN grupos ON alumno.grupo_id = grupos.id JOIN especialidad ON grupos.especialidad_id = especialidad.id"
    cursor.execute(query)
    alumnoss = cursor.fetchall()
    cursor.close()
    

        
    return render_template('alumnosVis.html', alumnos = alumnoss)

@app.route('/addAlum', methods=['POST'])
def addAlum():
    if request.method == 'POST':
        nombre = request.form['nombre']
        apellidoP = request.form['apellidoP']
        apellidoM = request.form['apellidoM']
        grupo_id = request.form['grupo']  # Obtén la descripción del grupo seleccionado
        rfid = request.form['rfid']
        correoT = request.form['correoT']
        
        cursor = conn.cursor()
        cursor.execute('INSERT INTO alumno (nombre, apellidoPaterno, apellidoMaterno, grupo_id, RFIDcard, CorreoTutor) VALUES (%s, %s, %s, %s, %s, %s)', (
            nombre, apellidoP, apellidoM, grupo_id, rfid, correoT
        ))
        conn.commit()
        cursor.close()
        return redirect(url_for('alumnosVis'))


@app.route('/editAlum/<string:id>')
def editAlum(id):
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM alumno WHERE id = %s', (id,))
    ediAlumnoVar = cursor.fetchall()
    return render_template('editarAlumno.html', alumno = ediAlumnoVar[0])


@app.route('/updateAlumno/<id>', methods = ['POST'])
def updateAlumno(id):
    if request.method == 'POST':
        nombre = request.form['nombre']
        apellidoP = request.form['apellidoP']
        apellidoM = request.form['apellidoM']
        grupo = request.form['grupo']
        rfid = request.form['rfid']
        correoT = request.form['correoT']

        cursor = conn.cursor()
        cursor.execute("""
        UPDATE alumno
        SET nombre = %s,
            apellidoPaterno = %s,
            apellidoMaterno = %s,
            grupo_id = %s,
            RFIDcard = %s, 
            CorreoTutor = %s
        WHERE id = %s
        """, (nombre, apellidoP, apellidoM, grupo, rfid, correoT, id))
        cursor.close()
        flash ('alumno actualizado')
        return redirect(url_for('alumnosVis'))

@app.route('/eliAlum/<string:id>')
def eliAlum(id):
    cursor = conn.cursor()
    cursor.execute('DELETE FROM alumno WHERE id= {0}'.format(id))
    cursor.close()
    flash('Alumno eliminado')

    return redirect(url_for('alumnosVis'))










@app.route('/materias')
def materiasVis():
    cursor = conn.cursor()
    query = "SELECT * FROM materia"
    cursor.execute(query)
    materias = cursor.fetchall()
    cursor.close
    return render_template('MateriasVis.html', materias = materias)



class Asistencia:
    cursor = conn.cursor()
    def get_maestro(self, uid):
        cursor = conn.cursor()
        sql_maestro = "SELECT * FROM maestro WHERE RFIDcard = %s"
        cursor.execute(sql_maestro, (uid,))
        return cursor.fetchone()
        
    def get_alumno(self, uid):
        cursor = conn.cursor()
        sql_alumno = "SELECT a.id, a.nombre, a.apellidoPaterno, a.apellidoMaterno, g.GradoYGrupo, e.nombre FROM alumno a JOIN grupos g ON a.grupo_id = g.id JOIN especialidad e ON g.especialidad_id = e.id WHERE a.RFIDcard = %s"
        cursor.execute(sql_alumno, (uid,))
        return cursor.fetchone()
        
    def get_horario(self, maestro_id, dia_de_la_semana):
        cursor = conn.cursor()
        sql_horario = "SELECT materia_id, materia.nombre, modulos.hora_inicio, modulos.hora_fin FROM horario JOIN materia ON horario.materia_id = materia.id JOIN modulos ON horario.modulo_id = modulos.id WHERE horario.maestro_id = %s AND horario.dia = %s"
        cursor.execute(sql_horario, (maestro_id, dia_de_la_semana))
        return cursor.fetchall()
        
    def obtener_materia_ids(self, maestro_id, dia_de_la_semana):
        horario = self.get_horario(maestro_id, dia_de_la_semana)
        materia_ids = [fila[0] for fila in horario]
        return materia_ids
        
    def registrar_asistencia(self, alumno_id, maestro_id, materia_id):
        cursor = conn.cursor()
        sql_asistencia = "INSERT INTO asistencia (alumno_id, maestro_id, materia_id, hora_de_entrada, fecha, asistio) VALUES (%s, %s, %s, %s, %s, %s)"
        hora_actual = datetime.now().strftime('%H:%M:%S')
        fecha_actual = datetime.now().strftime('%Y-%m-%d')
        cursor.execute(sql_asistencia, (alumno_id, maestro_id, materia_id, hora_actual, fecha_actual, True))
            
        conn.commit()


asistencia_objeto = Asistencia()


@app.route('/registrar_maestro/<rfid>', methods=['GET'])
def registrar_maestro(rfid):
    global maestro_uid, tiempo_registro_maestro

    if tiempo_registro_maestro is None or (datetime.now() - tiempo_registro_maestro) > timedelta(minutes=15):
        maestro_uid = None
        tiempo_registro_maestro = None

    if maestro_uid is None:
        maestro = asistencia_objeto.get_maestro(rfid)
        if maestro:
            maestro_uid = rfid
            tiempo_registro_maestro = datetime.now()

            return 'REDIRECT'
        else:
            print("no corresponde a ningun maestro")
            return 'NO_MAESTRO'
    else:
        print("error, ya se ha registrado maestro")
        if maestro_uid == rfid:
            maestro_uid = None
            tiempo_registro_maestro = None
            print("variable reiniciada")
            return jsonify({'message': 'Variables reiniciadas correctamente.'})
        return jsonify({'error': 'Ya se ha registrado un maestro.'})

@app.route('/registrar_asistencia/<rfid_alumno>', methods=['GET'])
def registrar_asistencia(rfid_alumno):
    global maestro_uid

    if maestro_uid is not None:
        alumno = asistencia_objeto.get_alumno(rfid_alumno)

        if alumno:
            alumno_id = alumno[0]
            maestro_id = asistencia_objeto.get_maestro(maestro_uid)[0]
            dia_de_la_semana = 'Lunes'  # datetime.now().strftime('%A')
            materia_ids = asistencia_objeto.obtener_materia_ids(maestro_id, dia_de_la_semana)

            if materia_ids:
                materia_id = materia_ids[0]
                asistencia_objeto.registrar_asistencia(alumno_id, maestro_id, materia_id)
                print("Exito", alumno[1])
                return jsonify({'message': f'Asistencia registrada para el alumno {alumno[1]}.'})
            else:
                print("error, el maestro no tiene horario programado hoy")
                return jsonify({'error': 'El maestro no tiene horario programado para hoy.'})
        else:
            maestro_uid = None
            tiempo_registro_maestro = None
            print("No corresponde a ningún alumno")
            if 'User-Agent' in request.headers and 'Arduino' in request.headers['User-Agent']:
                return 'REDIRECT'
            else:
                return redirect(url_for('registrar_maestro', rfid=''))
    else:
        print("No corresponde a ningún alumno")
        if 'User-Agent' in request.headers and 'Arduino' in request.headers['User-Agent']:
            return redirect(url_for('registrar_maestro', rfid=''), code=302)
        else:
            return redirect(url_for('registrar_maestro', rfid=''))
@app.route('/reiniciar_variables', methods=['GET'])
def reiniciar_variables():
    global maestro_uid
    maestro_uid = None
    return jsonify({'message': 'Variables reiniciadas correctamente.'})


#Prueba del correo
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'saseza8@gmail.com'
app.config['MAIL_PASSWORD'] = 'hmpsoizosjgdxpwm'

mail = Mail(app)
@app.route('/enviodemeil')
def envioMeil():
    # Crear el mensaje de correo
    cursor = conn.cursor()
    query = "SELECT CorreoTutor FROM alumno"
    msg = Message('Hola',
                  sender='saseza8@gmail.com',
                  recipients=['saseza8@icloud.com'])
    msg.body = "Hola, esto es un correo enviado desde Flask."

    # Enviar el mensaje de correo
    mail.send(msg)
    
    return 'Correo enviado' 










#configuracion de puerto

if __name__ == '__main__':
    app.run(host='192.168.0.178', 
        port=3000, debug=True)
    socketio.run(app)

