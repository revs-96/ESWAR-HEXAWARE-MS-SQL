# entity/Claim.py
class Claim:
    def __init__(self, claimId=None, claimNumber=None, dateFiled=None, claimAmount=None, status=None, clientId=None, policy=None):
        self.__claimId = claimId
        self.__claimNumber = claimNumber
        self.__dateFiled = dateFiled
        self.__claimAmount = claimAmount
        self.__status = status
        self.__clientId = clientId
        self.__policy = policy

    # Getters and Setters
    def get_claimId(self):
        return self.__claimId

    def set_claimId(self, claimId):
        self.__claimId = claimId

    def get_claimNumber(self):
        return self.__claimNumber

    def set_claimNumber(self, claimNumber):
        self.__claimNumber = claimNumber

    def get_dateFiled(self):
        return self.__dateFiled

    def set_dateFiled(self, dateFiled):
        self.__dateFiled = dateFiled

    def get_claimAmount(self):
        return self.__claimAmount

    def set_claimAmount(self, claimAmount):
        self.__claimAmount = claimAmount

    def get_status(self):
        return self.__status

    def set_status(self, status):
        self.__status = status

    def get_clientId(self):
        return self.__clientId

    def set_clientId(self, clientId):
        self.__clientId = clientId

    def get_policy(self):
        return self.__policy

    def set_policy(self, policy):
        self.__policy = policy

    def __str__(self):
        return f"Claim [claimId={self.__claimId}, claimNumber={self.__claimNumber}, dateFiled={self.__dateFiled}, claimAmount={self.__claimAmount}, status={self.__status}]"
