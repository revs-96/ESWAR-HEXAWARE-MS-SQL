# mainmod/MainModule.py
from src.dao.PolicyServiceImpl import PolicyServiceImpl
from src.dao.ClientServiceImpl import ClientServiceImpl
from src.dao.ClaimServiceImpl import ClaimServiceImpl
from src.entity.Policy import Policy
from src.entity.Client import Client
from src.entity.Claim import Claim

if __name__ == "__main__":
    policy_service = PolicyServiceImpl()
    client_service = ClientServiceImpl()
    claim_service = ClaimServiceImpl()

    while True:
        print("\nInsurance Management System")
        print("1. Create Client")
        print("2. Create Policy")
        print("3. Get Policy")
        print("4. Get All Policies")
        print("5. Update Policy")
        print("6. Delete Policy")
        print("7. Exit")
        choice = input("Enter your choice: ")

        if choice == '1':
            clientName = input("Enter client name: ")
            contactInfo = input("Enter contact info: ")
            policy = input("Enter policy: ")
            client = Client(clientName=clientName, contactInfo=contactInfo, policy=policy)
            client_service.createClient(client)
            print("Client created successfully!")


        # mainmod/MainModule.py

        elif choice == '2':

            policyName = input("Enter policy name: ")

            policyDescription = input("Enter policy description: ")

            # Create a new Policy instance using the parameters

            policy = Policy(policyName=policyName, policyDescription=policyDescription)

            policy_service.createPolicy(policy)

            print("Policy created successfully!")


        elif choice == '3':
            policyId = int(input("Enter policy ID: "))
            try:
                policy = policy_service.getPolicy(policyId)
                print(policy)
            except Exception as e:
                print(e)

        elif choice == '4':
            policies = policy_service.getAllPolicies()
            for policy in policies:
                print(policy)

        elif choice == '5':
            policyId = int(input("Enter policy ID: "))
            policyName = input("Enter new policy name: ")
            policyDescription = input("Enter new policy description: ")
            policy = Policy(policyId=policyId, policyName=policyName, policyDescription=policyDescription)
            policy_service.updatePolicy(policy)
            print("Policy updated successfully!")

        elif choice == '6':
            policyId = int(input("Enter policy ID: "))
            policy_service.deletePolicy(policyId)
            print("Policy deleted successfully!")

        elif choice == '7':
            print("Exiting...")
            break
        else:
            print("Invalid choice! Please try again.")
