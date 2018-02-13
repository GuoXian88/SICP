import collections
from random import choice
# represent cards in deck
Card = collections.namedtuple('Card',['rank','suit'])


class FrenchDeck:
    ranks = [str(n) for n in range(2, 11)] + list('JQKA')
    suits = 'spades diamonds clubs hearts'.split()
    # 2d array: count from inner loop. :)

    def __init__(self):
        self._cards = [Card(rank,suit) for suit in self.suits
                                        for rank in self.ranks]

    def __len__(self):
        return len(self._cards)

    def __getitem__(self, position):
        return self._cards[position]

# card representation
beer_card = Card('7', 'diamonds')
print(beer_card)

suit_values = dict(spades = 3, hearts = 2, diamonds = 1, clubs = 0)
print(len(suit_values), FrenchDeck.ranks.index('3'))

deck = FrenchDeck()
print(len(deck))

for card in deck:
    print(card)

for card in reversed(deck):
    print('r', card)
print('choose: ', choice(deck))
