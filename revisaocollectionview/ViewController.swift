//
//  ViewController.swift
//  revisaocollectionview
//
//  Created by Caroline Feldhaus de Souza on 20/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    //2 imagens por linha
    //imagem 1/3 da tela

    lazy var elefanteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let alturaCelula: CGFloat = (self.view.frame.height/3)/2.0 - 5
        layout.itemSize = CGSize(width: alturaCelula, height: alturaCelula)
        
        //espaco minimo entre elementos da mesma linha
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 40
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        //se nao colocar essa linha nada vai aparecer na tela
        collectionView.showsHorizontalScrollIndicator = true
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    var arrayElefantes: [Elefante] = []
    let api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCelula = UINib(nibName: "CelulaCustomizada", bundle: nil)
        
        elefanteCollectionView.register(nibCelula, forCellWithReuseIdentifier: CelulaCustomizada.id)
        // Do any additional setup after loading the view.
        
        //depois de estabelecer o layour, adicionar o collectionView na tela
        self.view.addSubview(elefanteCollectionView)
        
        elefanteCollectionView.delegate = self
        elefanteCollectionView.dataSource = self
        criaConstraints()
        
        self.view.backgroundColor = .red
        
        buscaElefantes()
    }
    
    func buscaElefantes() {
        
        //async background
        api.getElephants { elefantes, error in
            if let elefantesRecebidos = elefantes {
                self.arrayElefantes = elefantesRecebidos
                print(self.arrayElefantes)
                
                //se nao fizer isso vai dar erro de thread, que é um erro roxo
                DispatchQueue.main.async {
                //atualiaa a collectionview pq agora tem novos dados
                self.elefanteCollectionView.reloadData()
                }
            }
        }
    }
    
    fileprivate func criaConstraints() {
        //colocar constraints
        NSLayoutConstraint.activate([
            elefanteCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0/3.0),
            elefanteCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            elefanteCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            elefanteCollectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

//nos avisa quando acontece
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

//passa informacoes para ele
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayElefantes.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: CelulaCustomizada.id, for: indexPath) as! CelulaCustomizada
        
        let elefante = arrayElefantes[indexPath.row]
        
        celula.labelNome.text = elefante.name
        if let urlString = elefante.image {
            if let url = URL(string: urlString) {
        celula.imagem.load(url: url)
        }
        }
        return celula
    }
    
}

