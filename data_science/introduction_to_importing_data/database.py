from sqlalchemy import create_engine


engine = create_engine("sqlite:///home/thiago/Desktop/repoGit/datascience/data_camp_notebooks/data_science/introduction_to_importing_data/Chinook.sqlite")
con = engine.connect()
table_names = engine.table_names()
print(table_names)
