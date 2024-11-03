import matplotlib.pyplot as plt

# Read data from the file
filename = './output/sta_output/sta_worst_min_slack.txt'
lib_files = []
worst_slacks = []

with open(filename, 'r') as file:
    for line in file:
        if line.strip().endswith('.lib'):
            lib_files.append(line.strip())
        elif 'worst slack' in line:
            worst_slack = float(line.split()[-1])
            worst_slacks.append(worst_slack)

# Plotting as a line graph without a closed loop
plt.figure(figsize=(14, 6))
plt.plot(lib_files, worst_slacks, marker='o', color='b', linestyle='-', linewidth=1.5)

# Label each point with its slack value
for i, (lib, slack) in enumerate(zip(lib_files, worst_slacks)):
    plt.text(i, slack, f'{slack:.2f}', ha='center', va='bottom', fontsize=8, color='red')

plt.xticks(rotation=90, fontsize=8)
plt.xlabel('Library Files')
plt.ylabel('Worst Hold Slack')
plt.title('Worst Hold Slack Values for Different Library Files')
plt.tight_layout()
plt.grid(axis='y', linestyle='--', alpha=0.7)

# Save and show the plot
plt.savefig('./images/Lab14/WHS.png', dpi=300)
plt.show()
