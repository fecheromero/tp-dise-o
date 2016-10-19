package controller

import dominio.RepoDefault
import org.hibernate.Criteria
import dominio.pois.Review
import org.hibernate.criterion.Restrictions
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepoReviews extends RepoDefault<Review> {
	private static RepoReviews instance=new RepoReviews()
	private new(){
	}
	def public static RepoReviews getInstance(){
		return instance
	}
	override getEntityType() {
		typeof(Review)
	}

	override addQueryByExample(Criteria criteria, Review r) {
		if (r.usuario != null) {
			criteria.add(Restrictions.eq("usuario", r.usuario))
		}
	}

}
