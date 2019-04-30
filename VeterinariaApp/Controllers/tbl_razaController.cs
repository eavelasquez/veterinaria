using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using VeterinariaApp.Models;

namespace VeterinariaApp.Controllers
{
    public class tbl_razaController : Controller
    {
        private db_veterinariaEntities db = new db_veterinariaEntities();

        // GET: tbl_raza
        public ActionResult Index()
        {
            return View(db.tbl_raza.ToList());
        }

        // GET: tbl_raza/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_raza tbl_raza = db.tbl_raza.Find(id);
            if (tbl_raza == null)
            {
                return HttpNotFound();
            }
            return View(tbl_raza);
        }

        // GET: tbl_raza/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: tbl_raza/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codigo_r,nombre_r")] tbl_raza tbl_raza)
        {
            if (ModelState.IsValid)
            {
                db.tbl_raza.Add(tbl_raza);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(tbl_raza);
        }

        // GET: tbl_raza/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_raza tbl_raza = db.tbl_raza.Find(id);
            if (tbl_raza == null)
            {
                return HttpNotFound();
            }
            return View(tbl_raza);
        }

        // POST: tbl_raza/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigo_r,nombre_r")] tbl_raza tbl_raza)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_raza).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tbl_raza);
        }

        // GET: tbl_raza/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_raza tbl_raza = db.tbl_raza.Find(id);
            if (tbl_raza == null)
            {
                return HttpNotFound();
            }
            return View(tbl_raza);
        }

        // POST: tbl_raza/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_raza tbl_raza = db.tbl_raza.Find(id);
            db.tbl_raza.Remove(tbl_raza);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
