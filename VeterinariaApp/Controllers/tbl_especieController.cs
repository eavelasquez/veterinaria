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
    public class tbl_especieController : Controller
    {
        private db_veterinariaEntities db = new db_veterinariaEntities();

        // GET: tbl_especie
        public ActionResult Index()
        {
            return View(db.tbl_especie.ToList());
        }

        // GET: tbl_especie/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_especie tbl_especie = db.tbl_especie.Find(id);
            if (tbl_especie == null)
            {
                return HttpNotFound();
            }
            return View(tbl_especie);
        }

        // GET: tbl_especie/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: tbl_especie/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "codigo_e,nombre_e")] tbl_especie tbl_especie)
        {
            if (ModelState.IsValid)
            {
                db.tbl_especie.Add(tbl_especie);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(tbl_especie);
        }

        // GET: tbl_especie/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_especie tbl_especie = db.tbl_especie.Find(id);
            if (tbl_especie == null)
            {
                return HttpNotFound();
            }
            return View(tbl_especie);
        }

        // POST: tbl_especie/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "codigo_e,nombre_e")] tbl_especie tbl_especie)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tbl_especie).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tbl_especie);
        }

        // GET: tbl_especie/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            tbl_especie tbl_especie = db.tbl_especie.Find(id);
            if (tbl_especie == null)
            {
                return HttpNotFound();
            }
            return View(tbl_especie);
        }

        // POST: tbl_especie/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            tbl_especie tbl_especie = db.tbl_especie.Find(id);
            db.tbl_especie.Remove(tbl_especie);
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
