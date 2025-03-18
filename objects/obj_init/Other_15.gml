/// @description default dialogues

var tasks = []

tasks[task_types.go_to_room] = [
	{
		"en": "Go to room {door_number}."
	}
]

tasks[task_types.go_back_one_room] = [
	{
		"en": "You're cold. Go back one room."
	},
	{
		"en": "Wrong direction. Go back the way you came."
	}
]

tasks[task_types.go_to_another_floor] = [
	{
		"en": "Go {direction}stairs."
	},
	{
		"en": "Go {direction} one floor."
	}
]

tasks[task_types.talk_to_someone] = [
	 {
		 "en": "Talk to {name}. {s_pronoun}'s got a task for you."
	 },
	 {
		 "en": "I've heard {name} knows something. Why don't you talk to {o_pronoun}?"
	 }
]

tasks[task_types.find_item] = [
	{
		"en": "Find {article} {name}."
	}
]

var miscelaneous = [
    {
        "en": "Time's dance echoes forgotten dreams in the cosmic corridors."
    },
    {
        "en": "Surreal clock hands mock linearity in a timeless waltz."
    },
    {
        "en": "Moonlit shadows whisper secrets in the enigmatic theater of night."
    },
    {
        "en": "Emotions paint consciousness in a blurred kaleidoscope of self."
    },
    {
        "en": "Thoughts float weightlessly, colliding in a gravity-defying void."
    },
    {
        "en": "Laughter echoes through parallel universes, joy and sorrow united."
    },
    {
        "en": "Mirrors reflect fractured alternate selves with untold stories."
    },
    {
        "en": "Dreams flutter like ephemeral butterflies, leaving desires' residue."
    },
    {
        "en": "Time unravels destiny's threads in a tapestry of possibilities."
    },
    {
        "en": "Raindrops carry memories, falling like liquid whispers."
    },
    {
        "en": "Surreal carnival tents unfold in the theater of the mind."
    },
    {
        "en": "Celestial books written in stardust fill the cosmos' library."
    },
    {
        "en": "Quantum thoughts blur chaos and order in a cosmic ballet."
    },
    {
        "en": "The soul navigates an introspective labyrinth with reflective mirrors."
    },
    {
        "en": "Whispers linger in heartbeat gaps, a cosmic symphony playing."
    },
    {
        "en": "Celestial dialects converse, stars sharing universe secrets."
    },
    {
        "en": "Solitude's symphony echoes through introspective rooms."
    },
    {
        "en": "Reality wears a paradox mask, concealing life's enigmatic dance."
    },
    {
        "en": "Silver tears weep from the moon, telling tales of lost wishes."
    },
    {
        "en": "Shadows, transient companions, whisper truths in the cosmic dance."
    }
]

global.default_dialogues = { tasks, miscelaneous }