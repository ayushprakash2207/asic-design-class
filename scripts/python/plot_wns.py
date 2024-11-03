import matplotlib.pyplot as plt

# Step 1: Read data from the file
filename = './output/sta_output/sta_wns.txt'
lib_files = []
worst_slacks = []

with open(filename, 'r') as file:
    for line in file:
        # Process lines with "lib" for library name and "worst slack" for slack value
        if line.strip().endswith('.lib'):
            lib_files.append(line.strip())
        elif 'wns' in line:
            worst_slack = float(line.split()[-1])
            worst_slacks.append(worst_slack)

# Step 2: Plotting as a Line Graph with Annotations
plt.figure(figsize=(12, 6))
plt.plot(lib_files, worst_slacks, marker='o', color='b', linestyle='-')
plt.xticks(rotation=90, fontsize=8)
plt.xlabel('Library Files')
plt.ylabel('Worst Negative Slack')
plt.title('Worst Negative Slack Values for Different Library Files')
plt.tight_layout()
plt.grid(axis='y', linestyle='--', alpha=0.7)

# Annotate each point with its slack value
for i, (lib, slack) in enumerate(zip(lib_files, worst_slacks)):
    plt.text(i, slack, f'{slack:.2f}', ha='center', va='bottom', fontsize=8, color='red')

# Save the plot as an image file
plt.savefig('./images/Lab14/WNS.png', dpi=300)

# Show the plot
plt.show()
