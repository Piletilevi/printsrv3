namespace WindowsFormsApplication1
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnShowProperties = new System.Windows.Forms.Button();
            this.btnXReport = new System.Windows.Forms.Button();
            this.btnZReport = new System.Windows.Forms.Button();
            this.lblResult = new System.Windows.Forms.Label();
            this.tbResult = new System.Windows.Forms.TextBox();
            this.btnBeep = new System.Windows.Forms.Button();
            this.btnPrintString = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnShowProperties
            // 
            this.btnShowProperties.Location = new System.Drawing.Point(12, 12);
            this.btnShowProperties.Name = "btnShowProperties";
            this.btnShowProperties.Size = new System.Drawing.Size(129, 23);
            this.btnShowProperties.TabIndex = 0;
            this.btnShowProperties.Text = "ShowProperties";
            this.btnShowProperties.UseVisualStyleBackColor = true;
            this.btnShowProperties.Click += new System.EventHandler(this.btnShowProperties_Click);
            // 
            // btnXReport
            // 
            this.btnXReport.Location = new System.Drawing.Point(12, 41);
            this.btnXReport.Name = "btnXReport";
            this.btnXReport.Size = new System.Drawing.Size(129, 23);
            this.btnXReport.TabIndex = 1;
            this.btnXReport.Text = "XReport";
            this.btnXReport.UseVisualStyleBackColor = true;
            this.btnXReport.Click += new System.EventHandler(this.btnXReport_Click);
            // 
            // btnZReport
            // 
            this.btnZReport.Location = new System.Drawing.Point(12, 70);
            this.btnZReport.Name = "btnZReport";
            this.btnZReport.Size = new System.Drawing.Size(129, 23);
            this.btnZReport.TabIndex = 2;
            this.btnZReport.Text = "ZReport";
            this.btnZReport.UseVisualStyleBackColor = true;
            this.btnZReport.Click += new System.EventHandler(this.btnZReport_Click);
            // 
            // lblResult
            // 
            this.lblResult.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.lblResult.AutoSize = true;
            this.lblResult.Location = new System.Drawing.Point(9, 164);
            this.lblResult.Name = "lblResult";
            this.lblResult.Size = new System.Drawing.Size(62, 13);
            this.lblResult.TabIndex = 3;
            this.lblResult.Text = "Результат:";
            // 
            // tbResult
            // 
            this.tbResult.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.tbResult.Location = new System.Drawing.Point(12, 180);
            this.tbResult.Name = "tbResult";
            this.tbResult.Size = new System.Drawing.Size(415, 20);
            this.tbResult.TabIndex = 4;
            // 
            // btnBeep
            // 
            this.btnBeep.Location = new System.Drawing.Point(12, 99);
            this.btnBeep.Name = "btnBeep";
            this.btnBeep.Size = new System.Drawing.Size(129, 23);
            this.btnBeep.TabIndex = 5;
            this.btnBeep.Text = "Beep";
            this.btnBeep.UseVisualStyleBackColor = true;
            this.btnBeep.Click += new System.EventHandler(this.btnBeep_Click);
            // 
            // btnPrintString
            // 
            this.btnPrintString.Location = new System.Drawing.Point(12, 128);
            this.btnPrintString.Name = "btnPrintString";
            this.btnPrintString.Size = new System.Drawing.Size(129, 23);
            this.btnPrintString.TabIndex = 6;
            this.btnPrintString.Text = "PrintString";
            this.btnPrintString.UseVisualStyleBackColor = true;
            this.btnPrintString.Click += new System.EventHandler(this.btnPrintString_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(439, 212);
            this.Controls.Add(this.btnPrintString);
            this.Controls.Add(this.btnBeep);
            this.Controls.Add(this.tbResult);
            this.Controls.Add(this.lblResult);
            this.Controls.Add(this.btnZReport);
            this.Controls.Add(this.btnXReport);
            this.Controls.Add(this.btnShowProperties);
            this.Name = "Form1";
            this.Text = "Тест драйвера ФР";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnShowProperties;
        private System.Windows.Forms.Button btnXReport;
        private System.Windows.Forms.Button btnZReport;
        private System.Windows.Forms.Label lblResult;
        private System.Windows.Forms.TextBox tbResult;
        private System.Windows.Forms.Button btnBeep;
        private System.Windows.Forms.Button btnPrintString;

    }
}

