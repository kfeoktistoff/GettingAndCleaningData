## Workflow

'run_analysis.R' script does the following action sequence:

1. Downloading and extracting raw data
2. Reading dictionary entities - Activity and Feature
3. Reading and cleaning test dataset in the following way:
	1. Reads file 'subject_test.txt' with subjects and 'y_test.txt' with activities
	2. Merging observations set (X_test.txt file) with Subject and Activity which were loaded in the previous step. Activity name is used as activity value, not ID
	3. Each column is a feature. Sets column names accordingly
	4. Extract only columns 'activity', 'subject' and columns containing 'mean()' and 'std()' in names. 'Sqldf' package was used to achieve this.
4. Reading and cleaning train dataset in the same way as test dataset (see item 3). Dev note: reading and cleaning dataset code was extracted to separate function which was reused in the 3th and 4th items.
5. Union both test and train datasets. Sorting result dataset by Subject and Activity.
6. Transforming column names in readable form.
	1. During the cleaning data, raw symbols '-', '(', ')' was replaced with underline symbol. For example, 'mean()' was replaced with 'mean__'. So, firstly scripts replaces several underlined symbols with one: '__' is going to be '_'
	2. Then scripts removes underlined symbols from the end of a label
	3. Observations contain values for time and frequency domains. The labels start with 't' and 'f' accordingly. Scripts expands them to 'Time' and 'Frequency'. For example, 'tBodyAcc' is transformed to 'TimeBodyAcc'
	4. 'Mag' in the labels was expanded to 'Magnitude'
	5. 'BodyBody' typo in the labels was repladed with 'Body'
7. Creating the second dataset from the first one. The new dataset contains only average values of all observations of the 1st dataset grouping by subject and it's activity.
