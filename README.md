## 🎮 פרוייקט סיום DevOps – Pacman על AWS

🧾 תאור כללי
הפרויקט מציג תהליך DevOps מלא – החל משכפול קוד המקור של משחק Pacman מ־GitHub, דרך הקמת תשתית ענן ב־AWS באמצעות Terraform, ועד לפריסה חיה של המשחק על אשכול Kubernetes מנוהל (EKS).
המערכת נבנתה כולה מקוד, בגישת Infrastructure as Code, ומופעלת באמצעות תהליך CI/CD אוטומטי מבוסס GitHub Actions.
המטרה: להפוך כל שינוי בקוד, בין אם בתשתית או באפליקציה, לעדכון חי בענן – בלחיצת git push אחת בלבד.

---

### 🛠️ טכנולוגיות ושירותים עיקריים

1. **AWS EKS** – קוברנטיס מנוהל להרצת קונטיינרים בסביבת ענן  
2. **EC2 Auto Scaling Group** – להרצת 2 נודים מסוג `t3.medium`, עם ניהול משאבים אוטומטי  
3. **Elastic Load Balancer (ELB)** – חשיפה חיצונית של המשחק לציבור דרך כתובת IP קבועה  
4. **Node Group** – קבוצה מנוהלת של נודים שמריצים את הקונטיינרים באשכול  
5. **Terraform** – להקמת תשתיות באופן אוטומטי ומבוסס קוד (IaC)  
6. **S3 + DynamoDB** – לניהול state של Terraform ולנעילה במקביליות  
7. **GitHub Actions** – להרצת תהליך CI/CD אוטומטי על כל שינוי בענף `main`  
8. **kubectl** – לפריסה, ניהול ובדיקת משאבים בתוך ה־Kubernetes Cluster



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


---

### 🔁 קונסיסטנטיות מלאה ב־CI/CD

המערכת פועלת כיום כך שכל שינוי שמבוצע בענף `main` של GitHub מוביל אוטומטית ל־:

- ⚙️ עדכון התשתיות בענן באמצעות Terraform  
- 🚀 עדכון השירותים והרפליקות בקוברנטיס באמצעות kubectl

השינויים נכנסים לפעולה באופן אוטומטי, ללא צורך בהרצה ידנית, וממחישים תהליך CI/CD מלא – מהקוד ועד לענן.
  

---

### 🧠 אתגרים ופתרונות

- שימוש ב־Provider של קוברנטיס מתוך Terraform גרם לשגיאות הרשאות מול אשכול ה־EKS  
  ➜ הפתרון: מעבר להגדרה ידנית של ConfigMap מסוג `aws-auth` בעזרת `kubectl`

- הסנכרון הראשוני בין GitHub ל־Terraform דרש יצירת secrets והפרדת ערכים לקבצים מתאימים  
  ➜ פתרון: שימוש בקבצים `terraform.tfvars` ו־`backend.tf` עם ערכים רגישים בנפרד

- קובץ ה־Deployment דרש תיקון בערך `replicas`, והריצה נבדקה אוטומטית דרך GitHub Actions
 

---

### 📸 צילומי מסך (ישולבו ב־PDF)

* קונסולת AWS – Cluster, Nodes, EC2, Load Balancer  
* פלט של `kubectl get pods`, `kubectl get nodes`  
* GitHub Actions – ריצות ירוקות מוצלחות  
* האתר עצמו דרך ה־Load Balancer  

---

### 🌐 קישור לאתר החי (Load Balancer)

> [http://<כתובת-loadbalancer>] – (להחליף עם הכתובת בפועל)

---

### 🧩 מבנה תיקיות

.
├── terraform/
│ ├── main.tf
│ ├── variables.tf
│ ├── backend.tf
│ └── terraform.tfvars
├── k8s/
│ ├── pacman-roiavni-deployment.yaml
│ └── pacman-roiavni-service.yaml
├── .github/workflows/
│ └── deploy.yml
├── public/ # קוד המקור של המשחק
├── server.js
├── app.js
└── Dockerfile


---

### 📦 שלב עתידי – Docker + ECR עבור Node.js

האפליקציה בנויה כ־Node.js מלא, כולל server.js ו־app.js, עם Dockerfile שמבצע התקנה והרצה.
ניתן לבנות Docker Image, לדחוף אותו ל־Amazon ECR
ולעדכן את ה־Deployment של Kubernetes לשימוש בתמונה הפרטית.

* מתאים לארגונים שרוצים שליטה בקוד ובגרסאות  
* מאפשר להרחיב בקלות את הלוגיקה בעתיד  
* מדגים CI/CD מלא – גם על קוד אפליקציה, לא רק תשתית  

💡 לא נדרש בפרויקט, אך רלוונטי מאוד בתעשייה  

---

### 🧠 מה למדתי

* איך בונים תשתיות ב־AWS בצורה אוטומטית ומודולרית (Terraform)  
* איך מחברים בין קוד, תשתית ופריסה (CI/CD מלא)  
* איך מתמודדים עם באגים כמו הרשאות EKS או פודים שנופלים  
* איך בודקים כל שינוי בגיטהאב ויודעים שהוא מגיע לענן באמת  

---

### ✅ מצב סיום

* [x] הקלאסטר פעיל  
* [x] המשחק פועל  
* [x] כל שינוי ב־GitHub ➜ מגיע לענן  
* [x] מוכנות מלאה להגשה  


