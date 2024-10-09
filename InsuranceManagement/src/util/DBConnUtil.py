# src/util/DBConnUtil.py
import pyodbc

class DBConnUtil:
    @staticmethod
    def get_connection():
        # Connect to the new database InsuranceDB1
        connection_string = (
            "DRIVER={ODBC Driver 17 for SQL Server};"
            "SERVER=ESWARAVENKATASA\\SQLEXPRESS;"
            "DATABASE=InsuranceManagementDB;"
            "Trusted_Connection=yes;"
        )
        return pyodbc.connect(connection_string)
