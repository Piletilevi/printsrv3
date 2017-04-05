using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using DrvFRLib;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            Driver = new DrvFR();
        }
        DrvFR Driver;
        private void UpdateResult()
        {
            tbResult.Text = string.Format("Результат: {0}, {1}", Driver.ResultCode, Driver.ResultCodeDescription);
        }
        private void btnXReport_Click(object sender, EventArgs e)
        {
            Driver.PrintReportWithoutCleaning();
            UpdateResult();
        }

        private void btnZReport_Click(object sender, EventArgs e)
        {
            Driver.PrintReportWithCleaning();
            UpdateResult();
        }

        private void btnShowProperties_Click(object sender, EventArgs e)
        {
            Driver.ShowProperties();
            UpdateResult();
        }

        private void btnBeep_Click(object sender, EventArgs e)
        {
            Driver.Beep();
            UpdateResult();
        }

        private void btnPrintString_Click(object sender, EventArgs e)
        {
            Driver.StringForPrinting = "Тестовая строка";
            Driver.PrintString();
            UpdateResult();
        }
    }
}
