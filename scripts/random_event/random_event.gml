function random_event(probability) {
	if (probability > 1) throw $"The probability must be less than or equal to 1 (real: {probability})."
	
	return random(1) <= probability
}