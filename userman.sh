#!/bin/bash				


#Definition de la boucle principale
shutdown=1
while [ "$shutdown" == 1 ]
do
	clear
					
	echo "************************************************************************"				
	echo "*              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                          *"                               
	echo "*           ||   *   *  *****  *****  *****   ||                       *"
	echo "*           ||   *   *  *      *      *   *   ||                       *"
	echo "*           ||   *   *  *****  *****  ***     ||                       *"
	echo "*           ||   *   *      *  *      *  *    ||                       *"
	echo "*           ||   *****  *****  *****  *   *   ||                       *"
	echo "*              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                          *"

	echo "*   ~~~  Bienvenue dans votre assistant de gestion des utilisateurs ~~~*"
	echo "*                ~~~~~ User Management System ~~~~~                    *"
	echo "*                     ~~~~ Menu Principal ~~~~                         *"
	echo "*   1) Ajouter un/des utilisateur(s).                                  *"
	echo "*   2) Verifier l'existence d'un utilisateur.                          *"
	echo "*   3) Activer/Desactiver un utilisateur.                              *"
	echo "*   4) Supprimer un utilisateur.                                       *"
	echo "************************************************************************"  
	
	read -p "Veuillez choisir une option svp:  " reponse
	echo $reponse
#Repartition des traitements en fonction des choix
	
	case "$reponse" in
		"1")
		#Ici le code la 1ere option
		 clear
		 echo "~~~  User Management System  ~~~"
		 echo "Ici le code la premiere option"
		 echo "1) Ajouter les utilisateurs du fichier useradd.csv"
		 echo "2) Ajouter un utilisateur manuellement"
		 read -p "Veuillez choisir une option svp: " choix
		 if [ $choix == 1 ];
		 then
		  	echo "test 1"
			
			while read line;
			do
				x="$line"
				echo "$x" > line_user_add
				username=$(cut -d ";" -f 1 line_user_add)
				comment=$(cut -d ";" -f 4 line_user_add)
				expireDate=$(cut -d ";" -f 5 line_user_add) 
				group=$(cut -d ";" -f 6 line_user_add)
				sudo useradd -c "$comment" -e "$expireDate" -m "$username" 2>> erreur.txt
				sudo usermod -aG "$group" "$username" 2>> erreur.txt

			done < useradd.csv
		 else
		 	echo "test 2"
			echo "Entrer le nom d'utilisateur"
			read userName
			echo "Entrer le Nom (First Name)"
			read firstName
			echo "Entrer le Prenom (Last Name)"
			read lastName
			echo "Entrer un commentaire"
			read comment
			echo "Entrer une Date d'Expiration (yyyy-mm-dd)"
			read expireDate
			echo "Entrer les differents groupes auxquelles l'utilisateur appartient (groupe1,Groupe2,Groupe3)"
			read group

			sudo useradd -c "$comment" -e "$expireDate" -m "$userName"
			sudo usermod -aG "$group" "$userName"


		 fi
		 sleep 3
		;;
		
		"2")
		#Ici le code la 2eme option
		 clear
		 echo "~~~  User Management System  ~~~"
		 echo "Ici le code la deuxieme option"
		 echo "Entrer le nom d'utilisateur"
		 read username
		 check=$(grep $username /etc/passwd)
		 if [ $check != "" ];
		 then
			echo "L'utilisateur $username existe dans le systeme"
		 else
		 	echo "L'utilisateur $username est inexistant dans le systeme"
		 fi
		 sleep 3
		;;
		
		"3")
		#Ici le code la 3eme option
		 clear
		 echo "~~~  User Management System  ~~~"
		 
		 
		 echo "Ici le code la troisieme option"
		 echo "1) Activer un compte utlisateur"
		 echo "2) Desactiver un compte utilisateur"
		 read -p "Veuillez choisir une option svp: " choix

		case $choix in
		1)
				echo "Veilleur entre le nom d un utilisateur?"
		 		read varname
				sudo chage -E -1 $varname
				sudo chage -l $varname
		;;

		2)
				echo "Veilleur entre le nom d un utilisateur?"
		 		read varname
				sudo chage -E 0 $varname
				sudo chage -l $varname
		;;

		0)
				exit
		;;

		*)
				echo "Unknown"
		;;

		esac
		 sleep 3
		;;
		
		"4")
		#Ici le code la 4eme option
		 clear
		 echo "~~~  User Management System  ~~~"
		 echo "Entrer le nom de l'utilisateur a supprimer"
		read userName
		sudo deluser --backup-to /backup-user/ --remove-home "$userName"
		sleep 3 
		;;
		
		*)
		#Ici le code en cas d erreur de saisie
		 clear
		 echo "~~~  User Management System  ~~~"
		 echo "Desole cette option est invalide."
		 sleep 3
		;;
		
	esac
	
	#clear
	echo "~~~  User Management System  ~~~"
	echo "1) Menu principal"
	echo "2) Quitter l'assistant"
	read shutdown
done
		
