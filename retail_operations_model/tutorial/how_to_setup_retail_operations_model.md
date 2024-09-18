# Tutorial: Setting Up the Knowledge Graph Model in Timbr

## Step 1: Log In to Timbr
1. Open your web browser and navigate to [Timbr's login page](https://your_timbr_instance_url).
2. Connect to Timbr with your username and password/SSO.

## Step 2: Create a New Knowledge Graph
1. Once in Timbr, locate and click on the **Manage** tab above and choose **Knowledge Graphs**.
2. Click the **Create New Knowledge Graph** button on the top right.
3. Fill in the required fields:
   - **Assign to domain**: Optionally, select a domain to assign your knowledge graph to.
   - **Knowledge graph name**: Enter a name for your knowledge graph.
   - **Knowledge graph description**: Optionally, provide a description for your knowledge graph.
   
4. Click **Create Knowledge Graph** to finalize the creation of the knowledge graph.

## Step 3: Navigate to the SQL Editor
1. Once your knowledge graph is created, click on the **SQL Lab** tab in the navigation bar and select **SQL Editor**.
2. In the SQL Editor, ensure that your newly created knowledge graph is selected in the **Knowledge Graph** dropdown menu.

## Step 4: Load the SQL Script
1. Open the `.sql` file for the model you are setting up, which can be found in the `sql` folder in this repository.
2. Copy the entire SQL script.

## Step 5: Run the SQL Script in Timbr
1. Paste the copied SQL script into the SQL Editor in Timbr.
2. Click the **Run** button to execute the script.
3. Wait for the script to complete. You should see a message indicating that the query ran OK.

## Step 6: Verify the Ontology
1. Navigate to the **Model** tab in Timbr and choose **Ontology Explorer**.
2. Select your new knowledge graph.
3. Verify that the concepts and properties have been created as expected.

## Additional Notes
- If you encounter any errors during the setup process, refer to the [Timbr documentation](https://docs.timbr.ai/doc/).
