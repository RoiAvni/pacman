<h1 align="center" style="border:none; margin-bottom:0;">
🎮 פרויקט סיום DevOps – Pacman על AWS


---

<p align="center" style="font-size:2.2rem; font-weight:bold; margin-top:0;">
רואי אבני


---
### 🧾 תאור כללי

הפרויקט מציג תהליך DevOps מלא – החל משכפול קוד המקור של משחק Pacman מ־GitHub, דרך הקמת תשתית ענן ב־AWS באמצעות Terraform, ועד לפריסה חיה של המשחק על אשכול Kubernetes מנוהל (EKS).
המערכת נבנתה כולה מקוד, בגישת Infrastructure as Code, ומופעלת באמצעות תהליך CI/CD אוטומטי מבוסס GitHub Actions.
המטרה: להפוך כל שינוי בקוד, בין אם בתשתית או באפליקציה, לעדכון חי בענן – בלחיצת git push אחת בלבד.

---

### 🛠️ טכנולוגיות ושירותים עיקריים

**1.** קוברנטיס מנוהל להרצת קונטיינרים בסביבת ענן – **AWS EKS**  
**2.** להרצת 2 נודים מסוג `t3.medium`, עם ניהול משאבים אוטומטי – **EC2 Auto Scaling Group**  
**3.** לחשיפה חיצונית של המשחק לציבור דרך כתובת IP קבוצתית – **Elastic Load Balancer (ELB)**  
**4.** קבוצה מנוהלת של נודים שמריצים את הקונטיינרים באשכול – **Node Group**  
**5.** להקמת תשתיות באופן אוטומטי ומבוסס קוד (IaC) – **Terraform**  
**6.** לניהול ולאחסון מצב הריצה (`state`) של Terraform בפרויקטים – **S3 + DynamoDB**  
**7.** אוטומציה על כל שינוי בענף `main` להפעלת תהליך CI/CD – **GitHub Actions**  
**8.** פריסה, ניהול ובדיקת משאבים בתוך ה־Kubernetes Cluster – **kubectl**



---

### ⚙️ שלבי הפרויקט

1. **שכפול קוד המשחק** מהמאגר GitHub של הפרויקט המקורי והעלאתו לריפו אישי  
2. **יצירת קבצי Terraform** להקמת EKS, Node Group, Networking ו־IAM Roles  
3. **שימוש בקובץ `backend.tf`** לניהול state בענן בעזרת S3 + DynamoDB  
4. **הרצת `terraform apply`** מתוך GitHub Actions להקמה בפועל של המשאבים בענן  
5. **פריסת הקבצים הקוברנטיים (YAML)** – יצירת קובצי `Deployment` ו־`Service` מסוג LoadBalancer  
6. **הגדרה ידנית של `aws-auth ConfigMap`** עקב שגיאות ב־Terraform Provider  
7. **הוספת תהליך CI/CD אוטומטי עם GitHub Actions**:  
   * שלב 1: `terraform apply` אוטומטי על כל שינוי בתשתית  
   * שלב 2: `kubectl apply` אוטומטי על קובצי YAML  
8. **בדיקות סופיות** – ווידוא שיש 2 נודים, 2 פודים פעילים, והאתר מגיב דרך Load Balancer  
9. **שיפור קובצי YAML** – שינוי `replicas` ל־3 ולאחר מכן חזרה ל־2, דרך GitHub בלבד (ללא מגע ידני)  
10. **יצירת דיאגרמה אדריכלית** – הצגה גרפית של תהליך העבודה, תשתיות AWS, קובצי Terraform ו־GitHub Actions, באמצעות Draw.io

---

### 🔁 קונסיסטנטיות מלאה ב־CI/CD

המערכת פועלת כיום כך שכל שינוי שמבוצע בענף `main` של GitHub מוביל אוטומטית ל־:

- ⚙️ עדכון התשתיות בענן באמצעות Terraform  
- 🚀 עדכון השירותים והרפליקות בקוברנטיס באמצעות kubectl

השינויים נכנסים לפעולה באופן אוטומטי, ללא צורך בהרצה ידנית, וממחישים תהליך CI/CD מלא – מהקוד ועד לענן.
  

---

### 🧠 אתגרים ופתרונות

• שימוש ב־**Provider של Kubernetes מתוך Terraform** לצורך קבלת הרשאות מול אשכול ה־**EKS**  
🔁 הפתרון: מעבר להגדרה ידנית של `ConfigMap` מסוג `aws-auth` בעזרת `kubectl`

• הסנכרון הראשוני בין **Terraform ל־GitHub** דרש יצירת ערכים בקבצים מותאמים מראש  
🔁 הפתרון: שימוש בקבצים `backend.tf` ו־`terraform.tfvars` עם ערכים רגישים בנפרד

• קובץ ה־**Deployment** דרש תיקון בערך `replicas`, והריצה נבדקה אוטומטית דרך **GitHub Actions**  
🔁 הפתרון: עדכון הערך ישירות ב־GitHub והפעלת `kubectl apply` בתהליך ה־CI/CD

• למרות שהוגדרו 2 נודים בקבוצת ה־**Node Group** דרך Terraform, לעיתים הופעל רק נוד 1  
🔁 הפתרון: עדכון ידני של ההגדרה ל־`minSize=2` דרך ממשק AWS והפעלה מחודשת של קבוצת הנודים




 

---


### 🖼️ צילומי מסך

להלן צילומי מסך מהשלבים השונים שבוצעו במהלך הפרויקט:

**1.** קלאסטר פעיל ב־ **Amazon EKS** ←  
**2.** שני נודים פעילים באשכול  
**3.** מכונות **EC2** שהוקמו כחלק מ־ **Node Group**  
**4.** חשיפה ציבורית למשחק דרך **Load Balancer**  
**5.** פלט הפקודה `kubectl get nodes` – מציג שני נודים  
**6.** פלט הפקודה `kubectl get pods` – מציג שני פודים פעילים  
**7.** פלט הפקודה `kubectl get service` – שירות מסוג **LoadBalancer**  
**8.** בדיקה: שינוי ערך `replicas` מ־2 ל־3 וחזרה ל־2  
**9.** הרצת **GitHub Action** עבור **Terraform**  
**10.** הרצת **GitHub Action** עבור **kubectl**  
**11.** פריסת הקובץ `aws-auth.yaml` באמצעות `kubectl`  
**12.** הרצת משחק **Pac-Man** בענן דרך **LoadBalancer**  
**13.** תצוגת מבנה הקבצים והתיקיות בפרויקט דרך **VSCode**  
**14.** תרשים אדריכלות מלא – נוצר באמצעות **draw.io**, מציג את תהליך העבודה, תשתיות **AWS**, קבצי **Terraform** ו־**GitHub Actions**

> 📁 **הערה:** כל קבצי התמונות שמורים בתיקייה `screenshots/`


---

### 🌐 קישור לאתר החי (Load Balancer)
```
af81060c75fd2433dbbefedebbf259d7-2021084926.eu-west-3.elb.amazonaws.com
```

---

### 🧩 מבנה תיקיות

```
📁 root/
├── 📁 .github/workflows/ # קבצי GitHub Actions (CI/CD)
│ ├── 📄 deploy-kubectl.yml
│ └── 📄 terraform.yml
├── 📁 bin/ # קבצי שרת נוספים
│ └── 📄 server.js
├── 📁 diagrams/ # 🎨 דיאגרמות אדריכלות (PNG + DRAWIO)
│ ├── 📄 pacman-diagram.png
│ └── 📄 pacmen-diagram.drawio
├── 📁 docker/dev/ # סקריפטים ודוקר לפיתוח מקומי
│ ├── 📄 Dockerfile_nodejs_dev
│ ├── 📄 kill_pacman_dev.sh
│ ├── 📄 kill_pacman_mongo_dev.sh
│ ├── 📄 kill_pacman_nodejs_dev.sh
│ ├── 📄 start_pacman_dev.sh
│ ├── 📄 start_pacman_mongo_dev.sh
│ └── 📄 start_pacman_nodejs_dev.sh
├── 📁 k8s/ # קבצי YAML לפריסת Pac-Man על EKS
│ ├── 📄 aws-auth.yaml
│ ├── 📄 pacman-roiavni-deployment.yaml
│ └── 📄 pacman-roiavni-service.yaml
├── 📁 kubernetes/ # קבצי YAML ישנים
│ ├── 📄 deployment.yaml
│ └── 📄 service.yaml
├── 📁 lib/ # קבצי תצורה למסד נתונים
│ ├── 📄 config.js
│ └── 📄 database.js
├── 📁 public/ # קוד המקור של המשחק (HTML, CSS, JS, תמונות, אודיו)
│ ├── 📄 cache.manifest
│ ├── 📄 index.html
│ ├── 📄 pacman-canvas.css
│ ├── 📄 pacman-canvas.js
│ ├── 📄 style.css
│ ├── 📁 data/
│ │ └── 📄 map.json
│ ├── 📁 fonts/
│ │ ├── 📄 PressStart2Play.eot
│ │ ├── 📄 PressStart2Play.ttf
│ │ └── 📄 PressStart2Play.woff
│ ├── 📁 img/
│ │ ├── 📄 *.svg / *.png / Pacman-Icon.svg וכו'
│ │ └── 📁 instructions/
│ │ ├── 📄 instructions_chase.PNG
│ │ ├── 📄 instructions_powerpill.PNG
│ │ └── 📄 instructions_scatter.PNG
│ ├── 📁 js/
│ │ ├── 📄 jquery-3.4.1.min.js
│ │ └── 📄 jquery.hammer.min.js
│ ├── 📁 mp3/
│ │ └── 📄 *.mp3
│ └── 📁 wav/
│ └── 📄 *.wav
├── 📁 routes/ # נתיבי backend באפליקציה
│ ├── 📄 highscores.js
│ ├── 📄 location.js
│ └── 📄 user.js
├── 📁 screenshots/ # 📸 צילומי מסך של כל שלבי הפרויקט (01–14)
│ ├── 📄 1.eks-cluster.png
│ ├── 📄 ... (כולל pacman-diagram.png)
│ └── 📄 14.pacman-diagram.png
├── 📁 terraform/ # קוד תשתית AWS באמצעות Terraform
│ ├── 📄 main.tf
│ ├── 📄 outputs.tf
│ ├── 📄 variables.tf
│ ├── 📄 terraform.tfvars
│ ├── 📄 backend.tf
│ ├── 📄 .terraform.lock.hcl
│ └── 📁 .terraform/
│ └── 📁 providers/...
├── 📁 views/ # תבניות Jade להצגת דפי HTML
│ ├── 📄 error.jade
│ ├── 📄 index.jade
│ └── 📄 layout.jade
├── 📄 .dockerignore
├── 📄 .gitignore
├── 📄 app.js
├── 📄 Dockerfile
├── 📄 LICENSE
├── 📄 package.json
├── 📄 README.md
└── 📄 server.js
```

> 📝 **הערה**: בתיקיית `public/` נמצאים כל המשאבים הסטטיים להפעלת המשחק – כולל HTML, CSS, JavaScript, תמונות וצלילים.



---


### 🧱 שלב עתידי – Docker + ECR עבור Node.js

האפליקציה בנויה כ־**Node.js מלא**, כולל `app.js` ו־`server.js`, עם קובץ `Dockerfile` שמבצע התקנה והרצה.  
ניתן לבנות Docker Image, לדחוף אותו ל־**Amazon ECR**, ולעדכן את ה־Deployment של **Kubernetes** לשימוש בתמונה הפרטית.

- מתאים לארגונים שרוצים שליטה בקוד ובגרסאות  
- מאפשר להרחיב בקלות את הלוגיקה בעתיד  
- מדגים CI/CD מלא – גם על קוד אפליקציה, לא רק על תשתית

💡 לא נדרש לפרויקט – אך רלוונטי מאוד בתעשייה

---

### 🧠 מה למדתי

- איך בונים תשתיות בענן **AWS** בצורה אוטומטית ומודולרית (Terraform)
- איך מחברים בין קוד, תשתית ופריסה בתהליך **CI/CD מלא**
- איך מתמודדים עם אתגרים כמו הרשאות **EKS** או פודים שנופלים
- איך לוודא שכל שינוי ב־GitHub באמת מגיע לענן ונבדק בפועל
 

---

### ✅ מצב סיום

<p dir="rtl">

- ☑️ הקלאסטר פעיל  
- ☑️ המשחק פעיל  
- ☑️ כל שינוי ב־GitHub מגיע לענן ➜  
- ☑️ התהליך רץ אוטומטית דרך GitHub Actions בשלבי ה־CI/CD  
- ☑️ המשחק נחשף בענן בהצלחה דרך Load Balancer
- 
---

### 🚧 הרחבות שלא בוצעו

- 🏷️ **חיבור דומיין אישי (CNAME)** ל־Load Balancer היה מתוכנן כשלב בונוס, אך לא יושם עקב מגבלות תקציב ושימוש ב־AWS Route 53.


</p>





