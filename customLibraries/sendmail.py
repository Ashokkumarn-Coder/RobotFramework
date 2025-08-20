import smtplib #smtplib → Python’s library to send emails via SMTP (Simple Mail Transfer Protocol)
import ssl #ssl → To establish a secure TLS/SSL connection when sending mail.
from email.mime.multipart import MIMEMultipart #MIMEMultipart → Creates an email that can contain text + attachments (multi-part email).
from email.mime.base import MIMEBase  #MIMEBase → For adding binary attachments (like .html, .xml).
from email.mime.text import MIMEText #MIMEText → For adding plain text body content in the email.
from email import encoders
import os
import glob

print("📂 Current working directory:", os.getcwd())
#Defines a function that looks inside a given folder (result_folder) to find the latest report.html, log.html, and output.xml.
def get_latest_reports(result_folder="."):
    """Fetch the latest report, log, and output files from results folder"""

    #If no folder is passed, it automatically uses the folder where your script is saved
    if result_folder is None:
        # Use the folder where sendmail.py is located
        result_folder = os.path.dirname(os.path.abspath(__file__))

    patterns = ["report*.html", "log*.html", "output*.xml"]
    files = []
    for p in patterns:
        search_path = os.path.join(result_folder, p)
        print(f"🔍 Looking for: {search_path}")
        latest = sorted(glob.glob(search_path), key=os.path.getmtime, reverse=True)
        if latest:
            files.append(latest[0])
        else:
            print(f"⚠️ No match for {p}")
    return files

#glob.glob(search_path) → Finds all matching files.
#

def send_email_report(sender_email, app_password, receiver_emails, subject, body, attachments=[]):
    """Send email with attachments using Gmail + App Password"""
    try:
        # Ensure receivers are always a list
        if isinstance(receiver_emails, str):
            receiver_emails = [receiver_emails]

        # Create message
        msg = MIMEMultipart()
        msg['From'] = sender_email
        msg['To'] = ", ".join(receiver_emails)
        msg['Subject'] = subject

        # Email body
        msg.attach(MIMEText(body, 'plain'))

        # Attach files
        for file in attachments:
            if os.path.exists(file):
                with open(file, "rb") as f:
                    mime = MIMEBase('application', 'octet-stream')
                    mime.set_payload(f.read())
                    encoders.encode_base64(mime)
                    mime.add_header('Content-Disposition', f'attachment; filename={os.path.basename(file)}')
                    msg.attach(mime)
            else:
                print(f"⚠️ File not found, skipping: {file}")

        # Send email
        context = ssl.create_default_context()
        with smtplib.SMTP("smtp.gmail.com", 587) as server:
            server.set_debuglevel(1)   # 👈 enable debug output
            server.starttls(context=context)
            server.login(sender_email, app_password)
            server.sendmail(sender_email, receiver_emails, msg.as_string())

        print("✅ Report sent successfully!")

    except Exception as e:
        print(f"❌ Failed to send report: {e}")


if __name__ == "__main__":
    sender = "akn.ashu96@gmail.com"
    app_password = ""   # 🔑 use Gmail App Password (no spaces)
    receivers = [
        "akn.ashu96@gmail.com"
    ]

    subject = "Automation Test Report"
    body = "Hello Team,\n\nPlease find attached the latest automation reports.\n\nRegards,\nAutomation Bot"

    attachments = get_latest_reports(".")

    send_email_report(sender, app_password, receivers, subject, body, attachments)

attachments = get_latest_reports(".")
print("📎 Files to attach:", attachments)





