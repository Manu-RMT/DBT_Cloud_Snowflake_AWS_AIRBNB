# 🏠 Airbnb Data Engineering Project
### Pipeline End-to-End: AWS ➔ Snowflake ➔ dbt

Ce projet a pour objectif de transformer des données brutes Airbnb en un environnement analytique structuré. Il suit l'architecture **Medallion (Bronze, Silver, Gold)** pour garantir la qualité, la traçabilité et l'historisation des données.

---

## 🛠️ Stack Technique
* **Cloud Storage :** AWS S3 (Fichiers sources CSV)
* **Data Warehouse :** Snowflake
* **Transformation :** dbt (Data Build Tool)
* **Modélisation :** Architecture Medallion & Snapshots (SCD Type 2)

---

## 📑 Méthodologie du Projet

### 🏗️ Étape 1 : Ingestion & Configuration
* **Snowflake :** Création des *Stages* externes pour connecter Snowflake à **AWS S3**. Chargement initial des données dans un schéma de staging technique via la commande `COPY INTO`.
* **Configuration dbt :** * Initialisation du projet et paramétrage du `dbt_project.yml`.
   * Création de la macro `generate_schema_name.sql` pour automatiser la gestion des environnements (dev/prod).

### 🥉 Étape 2 : Couche Bronze (Raw Data)
* **Sources :** Déclaration des tables brutes `Host`, `Bookings` et `Listings`.
* **Data Cleaning :** Mise en place d'une logique de **suppression des doublons** parfaits pour assainir l'entrée du pipeline.
* **Validation :** Implémentation de tests de schéma (`unique`, `not_null`) dans le fichier `schema.yml`.

### 🥈 Étape 3 : Couche Silver (Transformation & Performance)
* **Modèles Incrémentaux :** Utilisation de la matérialisation `incremental` pour optimiser le traitement des gros volumes de données (ex: réservations).
* **Modularité :** Création de macros réutilisables pour standardiser les transformations de prix et de formats de date.

### 🥇 Étape 4 : Couche Gold (Analytics & Historisation)
* **OBT (One Big Table) :** Dénormalisation des données pour créer une table de reporting finale optimisée pour la BI.
* **Snapshots (SCD Type 2) :** Mise en place d'une capture d'historique sur la table des hôtes (`dim_airbnb_hosts`) pour suivre l'évolution de leurs attributs.
* **Optimisation :** Utilisation de modèles `ephemeral` pour les calculs intermédiaires.

### 🧪 Étape 5 : Qualité & Réconciliation (Tests Avancés)
* **Test `source_amount` :** Création d'un test de réconciliation financière sur-mesure.
* **Logique :** Ce test vérifie que la somme totale des montants de réservation (`BOOKING_AMOUNT`) est identique entre la source staging (après dédoublonnage) et la couche Bronze finale. Cela garantit qu'aucune donnée n'est perdue.

---

## 📈 Lignage des données (Lineage)



Le projet utilise le lignage natif de dbt pour assurer la traçabilité :
1. **Staging** ➔ Nettoyage et typage.
2. **Bronze** ➔ Unicité et stockage brut propre.
3. **Silver** ➔ Enrichissement et incrémental.
4. **Gold** ➔ Vision métier et historisation.



---

## 💻 Installation et Utilisation

1. **Installer les dépendances :**
  ```bash
  dbt deps

 

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
