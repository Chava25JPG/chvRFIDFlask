from random import sample
from .confBDControladores import Conexion

#Base de datos 
conexion = Conexion()
conn = conexion.connect_to_db()
cur = conn.cursor(dictionary=True)

def lista_Asistencia():

    querySQL = "SELECT * FROM asistencia"
    cur.execute(querySQL) 
    resultadoBusqueda = cur.fetchall() #fetchall () Obtener todos los registros
    totalBusqueda = len(resultadoBusqueda) #Total de busqueda
    
    cur.close() #Cerrando conexion SQL
    conn.close() #cerrando conexion de la BD    
    return resultadoBusqueda
