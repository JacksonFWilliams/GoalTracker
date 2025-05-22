<script>
	let goals = [];
	let newGoal = {
		title: '',
		description: '',
		targetDate: '',
		status: 'pending'
	};

	function addGoal() {
		if (newGoal.title.trim()) {
			goals = [...goals, { ...newGoal, id: Date.now() }];
			newGoal = {
				title: '',
				description: '',
				targetDate: '',
				status: 'pending'
			};
		}
	}

	function deleteGoal(id) {
		goals = goals.filter(goal => goal.id !== id);
	}

	function toggleStatus(id) {
		goals = goals.map(goal => 
			goal.id === id 
				? { ...goal, status: goal.status === 'completed' ? 'pending' : 'completed' }
				: goal
		);
	}
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
</svelte:head>

<main class="container">
	<h1>Goal Tracker</h1>
	
	<div class="add-goal-form">
		<h2>Add New Goal</h2>
		<form on:submit|preventDefault={addGoal}>
			<div class="form-group">
				<input
					type="text"
					bind:value={newGoal.title}
					placeholder="Goal title"
					required
				/>
			</div>
			<div class="form-group">
				<textarea
					bind:value={newGoal.description}
					placeholder="Goal description"
				></textarea>
			</div>
			<div class="form-group">
				<input
					type="date"
					bind:value={newGoal.targetDate}
				/>
			</div>
			<button type="submit">Add Goal</button>
		</form>
	</div>

	<div class="goals-list">
		<h2>Your Goals</h2>
		{#if goals.length === 0}
			<p class="no-goals">No goals yet. Add your first goal above!</p>
		{:else}
			{#each goals as goal (goal.id)}
				<div class="goal-card" class:completed={goal.status === 'completed'}>
					<div class="goal-content">
						<h3>{goal.title}</h3>
						<p>{goal.description}</p>
						{#if goal.targetDate}
							<p class="target-date">Target: {new Date(goal.targetDate).toLocaleDateString()}</p>
						{/if}
					</div>
					<div class="goal-actions">
						<button 
							class="status-btn"
							on:click={() => toggleStatus(goal.id)}
						>
							{goal.status === 'completed' ? '✓' : '○'}
						</button>
						<button 
							class="delete-btn"
							on:click={() => deleteGoal(goal.id)}
						>
							×
						</button>
					</div>
				</div>
			{/each}
		{/if}
	</div>
</main>

<style>
	.container {
		max-width: 800px;
		margin: 0 auto;
		padding: 2rem;
	}

	h1 {
		color: #2c3e50;
		text-align: center;
		margin-bottom: 2rem;
	}

	.add-goal-form {
		background: #f8f9fa;
		padding: 1.5rem;
		border-radius: 8px;
		margin-bottom: 2rem;
	}

	.form-group {
		margin-bottom: 1rem;
	}

	input, textarea {
		width: 100%;
		padding: 0.5rem;
		border: 1px solid #ddd;
		border-radius: 4px;
		font-size: 1rem;
	}

	textarea {
		min-height: 100px;
		resize: vertical;
	}

	button {
		background: #3498db;
		color: white;
		border: none;
		padding: 0.5rem 1rem;
		border-radius: 4px;
		cursor: pointer;
		font-size: 1rem;
	}

	button:hover {
		background: #2980b9;
	}

	.goals-list {
		margin-top: 2rem;
	}

	.goal-card {
		background: white;
		border: 1px solid #ddd;
		border-radius: 8px;
		padding: 1rem;
		margin-bottom: 1rem;
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
	}

	.goal-card.completed {
		background: #f8f9fa;
		opacity: 0.8;
	}

	.goal-content {
		flex: 1;
	}

	.goal-content h3 {
		margin: 0 0 0.5rem 0;
		color: #2c3e50;
	}

	.goal-content p {
		margin: 0;
		color: #666;
	}

	.target-date {
		font-size: 0.9rem;
		color: #888;
		margin-top: 0.5rem;
	}

	.goal-actions {
		display: flex;
		gap: 0.5rem;
	}

	.status-btn, .delete-btn {
		padding: 0.25rem 0.5rem;
		font-size: 1.2rem;
	}

	.delete-btn {
		background: #e74c3c;
	}

	.delete-btn:hover {
		background: #c0392b;
	}

	.no-goals {
		text-align: center;
		color: #666;
		font-style: italic;
	}
</style>
