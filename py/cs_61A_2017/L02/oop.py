'''
getattr(spock_account, 'balance')
We can also test whether an object has a named attribute with hasattr.
hasattr(spock_account, 'deposit')
True
'''

#class attribute
from datetime import date
class Account:
    interest = 0.02 # A class attribute
    def __init__(self, account_holder):
        self.balance = 0
        self.holder = account_holder


Account.__bool__ = lambda  self: self.balance != 0
spock_account = Account('Spock')
kirk_account = Account('Kirk')
print(spock_account.interest, kirk_account.interest)

Account.interest = 0.03
print(spock_account.interest, kirk_account.interest)

kirk_account.interest = 0.08
print(spock_account.interest, kirk_account.interest)
Account.interest = 0.05
print(spock_account.interest, kirk_account.interest)


print(repr(min), repr(Account), repr(spock_account))


tues = date(2011, 9, 12)

print(repr(tues), str(tues))

print(bool(Account('Jack')))