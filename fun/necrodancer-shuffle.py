#!/usr/bin/env python3

import random

ZONES = 5
FLOORS = 3

BOSSES = [
    'Deep Blues',
    'King Conga',
    'Death Metal',
    'Coral Riff',
    'Fortissimole',
]

SONGS = {
    (1, 1): 'Disco Descent',
    (1, 2): 'Crypteque',
    (1, 3): 'Mausoleum Mash',
    (2, 1): 'Fungal Funk',
    (2, 2): 'Grave Throbbing',
    (2, 3): 'Portabellohead',
    (3, 1): 'Stone Cold / Igneous Rock',
    (3, 2): 'Dance of the Decorous / March of the Profane',
    (3, 3): 'A Cold Sweat / A Hot Mess',
    (4, 1): 'Styx and Stones',
    (4, 2): 'Heart of the Crypt',
    (4, 3): 'The Wight to Remain',
    (5, 1): 'Voltzwaltz',
    (5, 2): 'Power Cords',
    (5, 3): 'Six Feet Thunder',
}

def get_floor_name(zone, floor):
    song = SONGS[(zone, floor)]
    return f'{zone}-{floor} {song}'

def get_boss_name(zone, boss):
    return f'    {boss} {zone}'

def generate_floor_shuffle():
    # Generate random bosses
    bosses = list(BOSSES)
    random.shuffle(bosses)

    # Generate shuffled floor levels
    floors = []
    for _ in range(FLOORS):
        zones = list(range(1, ZONES + 1))
        random.shuffle(zones)
        floors.append(zones)

    # Generate level specifications
    levels = []
    for zone_idx in range(ZONES):
        # Get each of the three floors for the zone
        for floor_idx in range(FLOORS):
            zone = floors[floor_idx][zone_idx]
            floor = floor_idx + 1
            levels.append(get_floor_name(zone, floor))

        # Get the boss for the zone
        boss = bosses[zone_idx]
        zone = zone_idx + 1
        levels.append(get_boss_name(zone, boss))

    return levels

if __name__ == '__main__':
    levels = generate_floor_shuffle()
    for i, level in enumerate(levels):
        print(level)

        if i % 4 == 3:
            print()
