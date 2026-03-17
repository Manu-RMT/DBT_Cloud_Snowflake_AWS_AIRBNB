-- 1. Définition du contexte : On indique à Snowflake d'utiliser la base de données spécifique
USE DATABASE airbnb_db;
USE SCHEMA STAGING;

-- 2. Création d'un objet "File Format" (Format de fichier)
-- Cet objet sert de règle de lecture pour que Snowflake sache comment interpréter les fichiers bruts

CREATE FILE FORMAT IF NOT EXISTS csv_format
  TYPE = 'CSV'                     -- Le fichier est au format texte séparé par des virgules
  FIELD_DELIMITER = ','            -- Le caractère de séparation des colonnes est la virgule
  SKIP_HEADER = 1                  -- On ignore la première ligne (généralement les entêtes)
  ENCODING='UTF8'
  ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE; -- Ne pas bloquer l'import si une ligne a un nombre de colonnes différent

-- Vérification : Affiche la liste des formats de fichiers créés dans la base actuelle
SHOW FILE FORMATS;

-- 3. Création d'un "Stage" (Zone de préparation externe)
-- C'est un connecteur qui pointe vers ton espace de stockage Cloud (Amazon S3)

CREATE OR REPLACE STAGE snowstage_aws
  FILE_FORMAT = csv_format         -- On lie ce stage au format de fichier créé précédemment
  URL = 's3://project-s3-manu/source/'; -- Chemin URL vers le dossier contenant les données sur AWS S3

-- Vérification : Affiche la liste des stages disponibles pour confirmer la création
SHOW STAGES;

COPY INTO BOOKINGS
FRoM @snowstage_aws
FILES=('bookings.csv')
CREDENTIALS=(aws_key_id = 'your_id', aws_secret_key = 'your_secret_key');

COPY INTO HOSTS
FRoM @snowstage_aws
FILES=('hosts.csv')
CREDENTIALS=(aws_key_id = 'your_id', aws_secret_key = 'your_secret_key');

COPY INTO LISTINGS
FRoM @snowstage_aws
FILES=('listings.csv')
CREDENTIALS=(aws_key_id = 'your_id', aws_secret_key = 'your_secret_key');


-- test 

SELECT count() from bookings order by created_at desc;
SELECT * from hosts order by created_at desc;
SELECT * from LISTINGS;
