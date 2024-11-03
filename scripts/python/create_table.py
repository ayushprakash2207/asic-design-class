import pandas as pd

# Step 1: Define the file paths individually
file_paths = [
    './output/sta_output/sta_worst_max_slack.txt',
    './output/sta_output/sta_worst_min_slack.txt',
    './output/sta_output/sta_tns.txt',
    './output/sta_output/sta_wns.txt'
]

# Step 2: Create an empty list to hold data
data = []

# Step 3: Process each file and extract data
for file_path in file_paths:
    with open(file_path, 'r') as file:
        # Extract the file name (without path) as the column prefix
        file_name = file_path.split('/')[-1]
        
        for line in file:
            # Process library file names and corresponding values
            if line.strip().endswith('.lib'):
                lib_file = line.strip()
            elif 'worst slack' in line:
                worst_slack = float(line.split()[-1])
                data.append({'Library File': lib_file, f'{file_name} - Worst Slack': worst_slack})
            elif 'wns' in line:  # Worst Negative Slack
                wns = float(line.split()[-1])
                data.append({'Library File': lib_file, f'{file_name} - WNS': wns})
            elif 'tns' in line:  # Total Negative Slack
                tns = float(line.split()[-1])
                data.append({'Library File': lib_file, f'{file_name} - TNS': tns})

# Step 4: Convert data into a DataFrame
df = pd.DataFrame(data)

# Step 5: Pivot the DataFrame to organize slack values by library file
df = df.pivot_table(index='Library File', aggfunc='first')  # 'first' in case of duplicates

df.columns = [
    'Total Negative Slack (TNS)',
    'Worst Negative Slack (WNS)',
    'Worst Setup Slack (Worst Slack)',
    'Worst Hold Slack (Worst Slack)'
]

# Step 7: Save the DataFrame as an HTML table
df.to_html('slack_values_table.html')

# Optional: Save the DataFrame as a Markdown table
markdown_table = df.to_markdown()
with open('slack_values_table.md', 'w') as f:
    f.write(markdown_table)

# Display the table
print(df)

# Save the table as a CSV file if needed
df.to_csv('slack_values_table.csv')

