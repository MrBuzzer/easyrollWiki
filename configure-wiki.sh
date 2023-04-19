#!/bin/bash

# Vérifiez si le fichier LocalSettings.php existe
if [ ! -f "${MW_INSTALL_PATH}/LocalSettings.php" ]; then
    # Si le fichier n'existe pas, copiez-le depuis l'emplacement par défaut
    cp "${MW_INSTALL_PATH}/LocalSettings.php.dist" "${MW_INSTALL_PATH}/LocalSettings.php"
fi

# Modifiez le fichier LocalSettings.php avec vos paramètres personnalisés
sed -i "s|\$wgSitename = \"MediaWiki\";|\$wgSitename = \"Votre site Wiki\";|" "${MW_INSTALL_PATH}/LocalSettings.php"
sed -i "s|\$wgMetaNamespace = \"MediaWiki\";|\$wgMetaNamespace = \"Votre espace de noms Wiki\";|" "${MW_INSTALL_PATH}/LocalSettings.php"
sed -i "