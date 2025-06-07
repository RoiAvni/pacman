# 🎮 Pac-Man על AWS עם Terraform, EKS ו-GitHub Actions – פרויקט גמר ב-DevOps

![Terraform CI](https://github.com/RoiAvni/pacman/actions/workflows/terraform.yml/badge.svg)
![Deploy CI](https://github.com/RoiAvni/pacman/actions/workflows/deploy-kubectl.yml/badge.svg)

---

## 📌 סקירה כללית

פרויקט הגמר שלי ב-DevOps מציג תהליך אוטומטי מלא לפריסת משחק Pac-Man על אשכול Kubernetes מנוהל (Amazon EKS), תוך שימוש ב-Terraform כקוד תשתית (IaC), וב-GitHub Actions לאוטומציה (CI/CD).

הפרויקט נבנה שלב אחר שלב – מהעתקת קוד המקור, דרך בניית תשתית בענן, ועד לפריסה מלאה ותחזוקה אוטומטית של היישום דרך GitHub.

---

## 🎯 מטרות הפרויקט

* להקים תשתית מלאה בענן באמצעות Terraform
* לפרוס את אפליקציית Pac-Man על אשכול EKS
* ליצור תהליך CI/CD מלא עם GitHub Actions
* להדגים שימוש מעשי בעקרונות DevOps בתעשייה

---

## 📁 מבנה התיקיות

```
.
├── terraform/                  # כל קבצי התשתית (Terraform)
├── k8s/                        # קבצי YAML של Kubernetes
├── .github/workflows/         # קובצי GitHub Actions
│   ├── terraform.yml
│   └── deploy-kubectl.yml
└── README.md                  # קובץ התיעוד
```

---

## 🧱 שלבי עבודה

### 1. 📥 העתקת קוד המקור של המשחק

* שיבוט של הריפו הפומבי [https://github.com/font/pacman](https://github.com/font/pacman)
* העתקת הקבצים הרלוונטיים (HTML, JS, CSS)
* העלאתם לריפו פרטי בגיטהאב עם מבנה מסודר

### 2. 🧱 הקמת תשתית עם Terraform

* יצירת קבצים: `main.tf`, `variables.tf`, `outputs.tf`, `terraform.tfvars`, `backend.tf`
* הגדרת משאבים:

  * `aws_eks_cluster`, `aws_eks_node_group`, `aws_iam_role`
  * תתי-רשתות (subnets), VPC, קבוצות אבטחה
* שימוש ב-S3 לשמירת state וב-DynamoDB לנעילה

### 3. 🧪 הרצת Terraform

```bash
terraform init -reconfigure
terraform plan
terraform apply
```

* התוצאה: אשכול EKS + NodeGroup פעילים בענן

### 4. 🔐 חיבור ל-EKS והרשאות גישה

* ניסיון לפרוס `aws_auth` דרך Terraform נכשל
* ✅ פתרון: יצרתי קובץ `aws-auth.yaml` ידני והפעלתי עם:

```bash
aws eks update-kubeconfig --name pacman-RoiAvni --region <region>
kubectl apply -f k8s/aws-auth.yaml
```

* זה מדגים טיפול בבעיה אמיתית ופתרון יצירתי בתנאי שטח

### 5. ☸️ פריסת Pac-Man עם Kubernetes

* נבנו שני קבצים:

  * `pacman-roiavni-deployment.yaml` – כולל הגדרת `replicas`
  * `pacman-roiavni-service.yaml` – כולל LoadBalancer
* הפעלה עם:

```bash
kubectl apply -f k8s/
```

### 6. 🔁 CI/CD – פריסת תשתית עם GitHub Actions

* קובץ `.github/workflows/terraform.yml`
* מריץ אוטומטית `terraform apply` על כל שינוי ב־`terraform/**`
* משתמש ב-Secrets של GitHub: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`

### 7. 🚀 CI/CD – פריסת אפליקציה עם kubectl

* קובץ `.github/workflows/deploy-kubectl.yml`
* מריץ `kubectl apply` אוטומטי על כל שינוי ב־YAML
* חיבור לקלאסטר עם `aws eks update-kubeconfig`

### 8. ✅ בדיקה אוטומטית

* שינוי `replicas: 2` ל־`3` וחזרה ל־`2` – דרך GitHub בלבד
* התוצאה: הפודים השתנו בהתאם – ללא הפעלת פקודות ידניות

### 9. 🧪 בדיקות סופיות

* LoadBalancer פעיל וציבורי
* GitHub Actions עובדים באופן אוטומטי
* קבצי YAML משנים את הפודים בענן בזמן אמת

### 10. 📦 ניקוי משאבים (לבודק)

* השארתי את כל המשאבים פעילים לצורכי בדיקה והצגה
* הבודק יכול למחוק לפי הצורך

---

## 🌐 קישור לאתר החי

🎮 **[שחקו Pac-Man כאן](http://<כתובת-load-balancer>)**

> החלף לכתובת האמיתית של ה־LoadBalancer שלך

---

## 🧰 טכנולוגיות בשימוש

* **Amazon EKS** – Kubernetes מנוהל
* **Terraform** – קוד תשתית
* **GitHub Actions** – אוטומציה ו־CI/CD
* **Kubernetes** – פריסת האפליקציה
* **S3 + DynamoDB** – שמירת מצב (state) של Terraform

---

## 🧠 אתגרים ופתרונות

| אתגר                                   | פתרון                                    |
| -------------------------------------- | ---------------------------------------- |
| `aws_auth` גרם לשגיאת הרשאות           | עברתי ל-YAML ידני ופתרתי עם `kubectl`    |
| `kubernetes provider` החזיר שגיאת טוקן | עברתי לפקודת CLI של `update-kubeconfig`  |
| NodeGroup לא עלו                       | עדכנתי את מדיניות ה-IAM וההרשאות הנדרשות |

---

## 📸 תמונות מומלצות לצרף

* Cluster ו־Nodes מתוך AWS Console
* GitHub Actions – הצלחה בשני הקבצים
* `kubectl get pods` + `kubectl get nodes`
* צילום מסך של המשחק פועל

---

## 🙋‍♂️ נכתב ע"י

**Roi Avni**
DevOps – פרויקט סיום 2025

---

## 🏁 סטטוס

✅ הפרויקט עובד בענן
✅ ה־CI/CD מלא ואוטומטי
✅ הכל נפרס בענן דרך GitHub בלבד

---

## 🧾 סיכום אישי

במהלך הפרויקט למדתי לחבר בין קוד ב־GitHub לבין תשתית אמיתית בענן, ולפתור תקלות כמו `aws-auth` או הרשאות של NodeGroup. זו הייתה הפעם הראשונה שיצרתי קלאסטר Kubernetes אמיתי – ואני מרוצה מהתוצאה: תהליך פריסה אוטומטי, נקי ומלא שעובד בענן אמיתי ללא צורך במעורבות ידנית.

---

## 💡 טיפים לבודק או למרצה

* התיקייה `terraform/` כוללת את כל הגדרות הענן
* קבצי YAML בתיקייה `k8s/` כוללים את הפריסה של Pac-Man
* ניתן לשנות ערך כמו `replicas` ב־GitHub ולראות שינוי מיידי בענן
* יש 2 GitHub Actions נפרדים – אחד לתשתית, אחד לפריסה
* ניתן לבדוק את כתובת ה־LoadBalancer לצפייה במשחק

---

## 🧠 דברים שלמדתי בפרויקט

* איך להקים תשתית אמיתית עם Terraform כולל backend בענן
* איך לחבר קובצי YAML לאשכול EKS בצורה נקייה ואוטומטית
* איך לפתור תקלות בשטח, כמו בעיות IAM או קונפיגורציה ב־kubectl
* איך להגדיר CI/CD שמגיב אוטומטית לשינויים מה־GitHub בלבד
* איך לחשוב כמו איש DevOps אמיתי – אוטומציה, הפרדה בין תשתית לאפליקציה, פתרון תקלות לבד
